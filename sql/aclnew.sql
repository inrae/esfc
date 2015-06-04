insert into aclappli (aclappli_id, appli) values (1, 'appli');
insert into aclaco (aclaco_id, aclappli_id, aco) values (1, 1, 'admin');
insert into acllogin (acllogin_id, login, logindetail) values (1, 'admin', 'admin');
insert into aclgroup (aclgroup_id, group) values (1, 'admin');
insert into acllogingroup (acllogin_id, aclgroup_id) values (1, 1);
insert into aclacl (aclaco_id, aclgroup_id) values (1, 1);
