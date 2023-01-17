<?php
/**
 * ORM de gestion de la table distribution
 *
 * @author quinton
 *        
 */
class Distribution extends ObjetBDD
{
	/**
	 * Constructeur de la classe
	 *
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "distribution";
		$this->id_auto = 1;
		$this->colonnes = array(
			"distribution_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"repartition_id" => array(
				"type" => 1,
				"requis" => 1,
				"parentAttrib" => 1
			),
			"bassin_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"repart_template_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"reste_zone_calcul" => array(
				"type" => 0
			),
			"reste_total" => array(
				"type" => 0
			),
			"evol_taux_nourrissage" => array(
				"type" => 1
			),
			"taux_nourrissage" => array(
				"type" => 1
			),
			"total_distribue" => array(
				"type" => 1
			),
			"distribution_masse" => array(
				"type" => 1
			),
			"distribution_consigne" => array(
				"type" => 0
			),
			"ration_commentaire" => array(
				"type" => 0
			),
			"taux_reste" => array(
				"type" => 0
			),
			"distribution_id_prec" => array(
				"type" => 0
			),
			"distribution_jour" => array(
				"type" => 0,
				"defaultValue" => "1,1,1,1,1,1,1"
			),
			"distribution_jour_soir" => array(
				"type" => 0,
				"defaultValue" => "0,0,0,0,0,0,0"
			)
		);
		parent::__construct($bdd, $param);
	}
	/**
	 * Surcharge de la fonction lire pour preparer les champs concernant les jours de distribution
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::lire()
	 */
	function lire($id, $getDefault = false, $parentValue = 0)
	{
		$data = parent::lire($id, $getDefault, $parentValue);
		/*
		 * Traitement des jours
		 */
		$distribJour = explode(",", $data["distribution_jour"]);
		for ($i = 0; $i < 7; $i++) {
			$data["distribution_jour_" . ($i + 1)] = $distribJour[$i];
		}
		$distribJourSoir = explode(",", $data["distribution_jour_soir"]);
		for ($i = 0; $i < 7; $i++) {
			$data["distribution_jour_soir_" . ($i + 1)] = $distribJourSoir[$i];
		}
		return ($data);
	}
	/**
	 * Surcharge de l'écriture, pour renseigner les
	 * donnees quotidiennes d'alimentation
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data)
	{
		/*
		 * Remise en forme du champ distribution_jour
		 */
		$data["distribution_jour"] = $data["distribution_jour_1"];
		for ($i = 2; $i <= 7; $i++) {
			$data["distribution_jour"] .= "," . $data["distribution_jour_" . $i];
		}
		/*
		 * Remise en forme du champ distribution_jour_taux
		 */
		$data["distribution_jour_soir"] = $data["distribution_jour_soir_1"];
		for ($i = 2; $i <= 7; $i++) {
			$data["distribution_jour_soir"] .= "," . $data["distribution_jour_soir_" . $i];
		}
		$id = parent::ecrire($data);
		if ($id > 0) {
			/*
			 * Relecture, pour récupérer les données de restes
			 */
			$data = $this->lire($id);
			/*
			 * Ecriture de la repartition quotidienne des aliments
			 */
			$repartition = new Repartition($this->connection, $this->paramori);
			$dataRepartition = $repartition->lire($data["repartition_id"]);
			$dateDebut = DateTime::createFromFormat('d/m/Y', $dataRepartition['date_debut_periode']);
			$dateFin = DateTime::createFromFormat('d/m/Y', $dataRepartition["date_fin_periode"]);
			$dateDiff = date_diff($dateDebut, $dateFin, true);
			$nbJour = $dateDiff->format("%a");
			/*
			 * Lecture des donnees de la repartition
			 */
			$repartAliment = new RepartAliment($this->connection, $this->paramori);
			$dataRepartAliment = $repartAliment->getFromTemplate($data["repart_template_id"]);
			/*
			 * Instanciation des tables a mettre a jour
			 */
			$distribQuotidien = new DistribQuotidien($this->connection, $this->paramori);
			$alimentQuotidien = new AlimentQuotidien($this->connection, $this->paramori);
			/*
			 * Mise en forme facile a utiliser
			 */
			foreach ($dataRepartAliment as $key => $value) {
				$aliment[$value["aliment_id"]] = $value["repart_alim_taux"];
			}
			/*
			 * Preparation du reste
			 */
			if (strlen($data["reste_zone_calcul"]) > 0) {
				$reste = explode("+", $data["reste_zone_calcul"]);
			}
			/*
			 * Mise en forme du tableau de jour de distribution
			 */
			$distribJour = explode(",", $data["distribution_jour"]);
			$distribJourSoir = explode(",", $data["distribution_jour_soir"]);
			$i = 0;
			while ($dateDebut <= $dateFin) {
				/*
				 * Suppression des enregistrements precedents
				 */
				$alimentQuotidien->deleteFromDateBassin(date_format($dateDebut, "Y-m-d"), $data["bassin_id"]);
				$distribQuotidien->deleteFromDateBassin(date_format($dateDebut, "Y-m-d"), $data["bassin_id"]);
				/*
				 * Recuperation du numero de jour
				 */
				$numJour = date_format($dateDebut, "w");
				if ($numJour == 0)
					$numJour = 7;
					
					/*
				 * Ecriture de l'enregistrement distrib_quotidien
				 */
				$dataDistrib = array(
					"distrib_quotidien_id" => 0,
					"bassin_id" => $data["bassin_id"],
					"distrib_quotidien_date" => date_format($dateDebut, "d/m/Y"),
					"total_distribue" => $data["total_distribue"],
					"reste" => $reste[$i]
				);
				/*
				 * On vérifie que l'aliment a été distribué ce jour-là
				 */
				if ($distribJour[$numJour - 1] != 1) {
					$dataDistrib["total_distribue"] = 0;
				}
				/*
				 * Recalcul de la quantité si distribution uniquement le soir à 50 %
				 */
				if ($distribJourSoir[$numJour - 1] == 1) {
					$dataDistrib["total_distribue"] = $dataDistrib["total_distribue"] * 0.5;
				}
				$idDataDistrib = $distribQuotidien->ecrire($dataDistrib);
				if ($idDataDistrib > 0 && $distribJour[$numJour - 1] == 1) {
					/*
					 * Ecriture des donnees quotidiennes des aliments
					 */
					foreach ($aliment as $cle => $taux) {
						$dataAlimQuot = array(
							"aliment_quotidien_id" => 0,
							"aliment_id" => $cle,
							"distrib_quotidien_id" => $idDataDistrib,
							"quantite" => intval($dataDistrib["total_distribue"] * $taux / 100)
						);
						$alimentQuotidien->ecrire($dataAlimQuot);
					}
				}
				$i++;
				/*
				 * Incrementation de la date
				 */
				$dateDebut->add(new DateInterval("P1D"));
			}
		}
		return ($id);
	}
	/**
	 * Ecrit les restes dans la table
	 *
	 * @param array $data        	
	 * @return integer
	 */
	function ecrireReste($data)
	{
		$erreur = 0;
		if (strlen($data["date_debut_periode"]) > 0 && strlen($data["date_fin_periode"]) > 0 && $data["distribution_id"] > 0) {
			/*
			 * Ecriture de la zone contenant l'ensemble des restes quotidiens
			 */
			$dateDebut = DateTime::createFromFormat('d/m/Y', $data['date_debut_periode']);
			$dateFin = DateTime::createFromFormat('d/m/Y', $data["date_fin_periode"]);
			$dateDiff = date_diff($dateDebut, $dateFin, true);
			$nbJour = $dateDiff->format("%a");
			$data["reste_zone_calcul"] = "";
			for ($i = 0; $i <= $nbJour; $i++) {
				if ($i > 0)
					$data["reste_zone_calcul"] .= "+";
				$data["reste_zone_calcul"] .= $data["reste_" . $i];
			}
			$ret = parent::ecrire($data);
			if ($ret > 0) {
				/*
				 * Ecriture des données quotidiennes
				 */
				$di = new DateInterval("P1D");
				$distribQuotidien = new DistribQuotidien($this->connection, $this->paramori);
				for ($i = 0; $i <= $nbJour; $i++) {
					/*
					 * Lecture de l'enregistrement précédent, qui doit exister
					 */
					$dataDistrib = $distribQuotidien->lireFromDate($data["bassin_id"], $dateDebut->format("d/m/Y"));
					if ($dataDistrib["distrib_quotidien_id"] > 0) {
						$dataDistrib["reste"] = $data["reste_" . $i];
						$ret1 = $distribQuotidien->ecrire($dataDistrib);
						if (!$ret1 > 0) {
							$erreur = 1;
							$this->errorData[] = $distribQuotidien->getErrorData(0);
						}
					}
					date_add($dateDebut, $di);
				}
			}
			if ($erreur != 0)
				return -1;
			else
				return $ret;
		}
	}
	/**
	 * Lit toutes les distributions à partir du numéro de répartition
	 *
	 * @param int $repartition_id        	
	 * @return array
	 */
	function getFromRepartition($repartition_id)
	{
		if ($repartition_id > 0 && is_numeric($repartition_id)) {
			$sql = "select t1.distribution_id, t1.repartition_id, t1.bassin_id,
				t1.repart_template_id, t1.reste_zone_calcul, t1.evol_taux_nourrissage,
				t1.taux_nourrissage, t1.total_distribue, t1.distribution_consigne,
				t1.ration_commentaire, t1.distribution_masse, t1.distribution_jour,
				t1.distribution_jour_soir,
				t1.reste_total, t1.taux_reste, t1.distribution_id_prec,
				bassin_nom, bassin.actif," .
				/*t2.reste_total as reste_precedent,
				t2.taux_reste as taux_reste_precedent,*/ "
				t2.total_distribue as total_distrib_precedent,
				t2.ration_commentaire as ration_commentaire_precedent,
				t2.taux_nourrissage as taux_nourrissage_precedent,
				bu.categorie_id as bassin_usage_categorie_id,
				rt.categorie_id as repart_template_categorie_id
				from distribution t1 
				join bassin using (bassin_id)
				left outer join bassin_usage as bu using (bassin_usage_id)
				left outer join repart_template as rt using (repart_template_id)
				left outer join distribution t2 on (t2.distribution_id = t1.distribution_id_prec)
				where t1.repartition_id = " . $repartition_id . "
				order by bassin_nom";
			$data = $this->getListeParam($sql);
			/*
			 * Recuperation des dates de la repartition
			 */
			$repartition = new Repartition($this->connection, $this->paramori);
			$dataRepart = $repartition->lire($repartition_id);
			$date_debut = date_create_from_format("d/m/Y", $dataRepart["date_debut_periode"]);
			$date_fin = date_create_from_format("d/m/Y", $dataRepart["date_fin_periode"]);
			$intervalle = $date_debut->diff($date_fin);
			$nbJour = $intervalle->format('%a') + 1;
			$di_intervalle = new DateInterval("P" . ($nbJour) . "D");
			// $date_debut->sub($di_intervalle);

			$distriQuotidien = new DistribQuotidien($this->connection, $this->paramori);
			$p1d = new DateInterval("P1D");
			/*
			 * Mise en forme des jours de distribution
			 */
			foreach ($data as $key => $value) {
				$distribJour = explode(",", $value["distribution_jour"]);
				$distribJourSoir = explode(",", $value["distribution_jour_soir"]);
				for ($i = 0; $i < 7; $i++) {
					$data[$key]["distribution_jour_" . ($i + 1)] = $distribJour[$i];
					$data[$key]["distribution_jour_soir_" . ($i + 1)] = $distribJourSoir[$i];
				}
				/*
				 * Calcul de la distribution globale
				 */
				$data[$key]["total_periode_distribue"] = 0;
				$date_debut = date_create_from_format("d/m/Y", $dataRepart["date_debut_periode"]);
				for ($i = 1; $i <= $nbJour; $i++) {
					$dataDistrib = $distriQuotidien->lireFromDate($value["bassin_id"], $date_debut->format("d/m/Y"));
					$data[$key]["total_periode_distribue"] += $dataDistrib["total_distribue"];
					$date_debut->add($p1d);
				}
				/*
				 * Calcul des distributions et restes précédents
				 */
				$dateDeb = date_create_from_format("d/m/Y", $dataRepart["date_debut_periode"]);
				$dateDeb->sub($di_intervalle);
				$data[$key]["total_periode_distrib_precedent"] = 0;
				$data[$key]["total_reste_precedent"] = 0;
				/*
				 * Lecture des consommations et restes quotidiens
				 */
				for ($i = 1; $i <= $nbJour; $i++) {
					$dataDistrib = $distriQuotidien->lireFromDate($value["bassin_id"], $dateDeb->format("d/m/Y"));
					$data[$key]["total_periode_distrib_precedent"] += $dataDistrib["total_distribue"];
					$data[$key]["reste_precedent"] += $dataDistrib["reste"];
					$dateDeb->add($p1d);
				}
				/*
				 * Calcul du taux de reste
				 */
				if ($data[$key]["total_periode_distrib_precedent"] > 0) {
					$data[$key]["taux_reste_precedent"] = round(($data[$key]["reste_precedent"] / $data[$key]["total_periode_distrib_precedent"] * 100), 2);
				} else {
					$data[$key]["taux_reste_precedent"] = 0;
				}
			}
			return ($data);
		}
	}
	/**
	 * Retourne la liste des bassins associés à une répartition,
	 * avec les bassins qui peuvent en faire également partie
	 *
	 * @param int $repartition_id        	
	 * @param int $categorie_id        	
	 * @return array
	 */
	function getFromRepartitionWithBassin($repartition_id, $categorie_id, $site_id = 0)
	{
		if ($repartition_id > 0 && is_numeric($repartition_id)) {
			$data = $this->getFromRepartition($repartition_id);
			/*
			 * Recuperation des bassins du même type
			 */
			if ($categorie_id > 0 && is_numeric($categorie_id)) {
				$sql = "select distinct bassin_id, bassin_nom
						from bassin
						join bassin_usage using (bassin_usage_id)
						where actif = 1
						and categorie_id = :categorie_id";
				$param = array("categorie_id" => $categorie_id, "repartition_id" => $repartition_id);
				if ($site_id > 0) {
					$sql .= " and site_id = :site_id";
					$param["site_id"] = $site_id;
				}
				$sql .= " and bassin_id not in
						(select bassin_id from distribution where repartition_id = :repartition_id)
						order by bassin_nom";
				$dataBassin = $this->getListeParamAsPrepared($sql, $param);
				/*
				 * Rajout des bassins à la liste
				 */
				foreach ($dataBassin as $key => $value) {
					$value["distribution_id"] = 0;
					/*
					 * Rajout des distributions quotidiennes par defaut
					 */
					for ($i = 1; $i <= 7; $i++) {
						$value["distribution_jour_" . $i] = 1;
						$value["distribution_jour_soir_" . $i] = 0;
					}
					$data[] = $value;
				}
				return $data;
			}
		}
	}
	/**
	 * Calcule la quantite de nourriture a distribuer globalement
	 *
	 * @param int $repartition_id        	
	 * @return array
	 */
	function calculDistribution($repartition_id)
	{
		if ($repartition_id > 0 && is_numeric($repartition_id)) {
			$sql = 'select bassin_nom, aliment_id, taux_nourrissage, evol_taux_nourrissage, total_distribue, repart_alim_taux, 
					round (total_distribue * repart_alim_taux / 100) as "quantite",
					round (total_distribue * repart_alim_taux  * matin / 10000) as "quantiteMatin",
					round (total_distribue * repart_alim_taux * midi / 10000) as "quantiteMidi",
					round (total_distribue * repart_alim_taux * soir / 10000) as "quantiteSoir",
					round (total_distribue * repart_alim_taux * nuit / 10000) as "quantiteNuit",
					distribution_consigne, distribution_masse, distribution_jour, aliment_type_id
					from distribution
					join repart_template using (repart_template_id)
					join repart_aliment using (repart_template_id)
					join aliment using (aliment_id)
					join bassin using (bassin_id)
					where repartition_id = ' . $repartition_id . "
					order by bassin_nom";
			return ($this->getListeParam($sql));
		}
	}
	/**
	 * Retourne la liste des aliments utilisés dans une distribution
	 *
	 * @param int $repartition_id        	
	 * @return array
	 */
	function getListeAlimentFromRepartition($repartition_id, $order = "adulte")
	{
		if ($repartition_id > 0 && is_numeric($repartition_id)) {
			$sql = "select distinct aliment_id, aliment_libelle_court, aliment_type_id
					from distribution
					join repart_template using (repart_template_id)
					join repart_aliment using (repart_template_id)
					join aliment using (aliment_id)
					where repartition_id = " . $repartition_id;
			if ($order == "adulte") {
				$order = " order by aliment_libelle_court";
			}
			if ($order == "juvenile") {
				$order = " order by aliment_type_id desc, aliment_libelle_court";
			}

			return ($this->getListeParam($sql . $order));
		}
	}
}