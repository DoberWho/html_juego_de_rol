CREATE SCHEMA juego_de_rol;

CREATE SCHEMA rol;

CREATE TABLE juego_de_rol.capitulos ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	titulo               varchar(150)  NOT NULL    ,
	description          text      ,
	cuando               varchar(100)      ,
	orden                tinyint UNSIGNED     
 );

CREATE TABLE juego_de_rol.caracteristicas_rol ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	fuerza               int UNSIGNED     ,
	destreza             int UNSIGNED     ,
	constitucion         int UNSIGNED     ,
	inteligencia         int UNSIGNED     ,
	sabiduria            int UNSIGNED     ,
	carisma              int UNSIGNED     
 );

CREATE TABLE juego_de_rol.carasteristicas_fisicas ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	altura               int UNSIGNED     ,
	peso                 int UNSIGNED     ,
	genero               int UNSIGNED  DEFAULT 0   
 );

ALTER TABLE juego_de_rol.carasteristicas_fisicas MODIFY genero int UNSIGNED  DEFAULT 0  COMMENT '0 - masculino.\n1 - femenino.\n2 - otros';

CREATE TABLE juego_de_rol.habilidades ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	descripcion          varchar(250)      
 );

CREATE TABLE juego_de_rol.languages ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	code                 varchar(3)  NOT NULL    ,
	label                varchar(100)  NOT NULL    
 );

CREATE TABLE juego_de_rol.lugares ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nonbre               varchar(150)  NOT NULL    ,
	descripcion          text      
 );

CREATE TABLE juego_de_rol.persona ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	apellidos            varchar(150)  NOT NULL    ,
	apodo                varchar(150)      
 );

CREATE TABLE juego_de_rol.raza ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 );

CREATE TABLE juego_de_rol.tipo_relacion ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 );

CREATE TABLE juego_de_rol.trabajo ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 );

CREATE TABLE juego_de_rol.anecdotas ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	titulo               varchar(150)  NOT NULL    ,
	description          text      ,
	id_persona           int UNSIGNED     ,
	cuando               timestamp      
 );

CREATE INDEX fk_anecdotas_persona ON juego_de_rol.anecdotas ( id_persona );

CREATE TABLE juego_de_rol.capitulos_cuerpo ( 
	id_capitulo          int UNSIGNED NOT NULL    ,
	id_language          int UNSIGNED NOT NULL    ,
	cuerpo               text      ,
	CONSTRAINT pk_capitulos_cuerpo PRIMARY KEY ( id_capitulo, id_language )
 );

CREATE INDEX fk_capitulos_cuerpo_languages ON juego_de_rol.capitulos_cuerpo ( id_language );

CREATE TABLE juego_de_rol.mn_anecdota_capitulo ( 
	id_anecdota          int UNSIGNED     ,
	id_capitulo          int UNSIGNED     
 );

CREATE INDEX fk_mn_personaje_anectdota_0_capitulos ON juego_de_rol.mn_anecdota_capitulo ( id_capitulo );

CREATE INDEX fk_mn_personaje_anectdota_anecdotas_0 ON juego_de_rol.mn_anecdota_capitulo ( id_anecdota );

CREATE TABLE juego_de_rol.mn_anecdotas_relacionadas ( 
	id_anecdota          int UNSIGNED     ,
	id_relacionada       int UNSIGNED     
 );

CREATE INDEX fk_mn_anecdotas_relacionadas_anecdotas ON juego_de_rol.mn_anecdotas_relacionadas ( id_anecdota );

CREATE INDEX fk_mn_anecdotas_relacionadas_anecdotas_0 ON juego_de_rol.mn_anecdotas_relacionadas ( id_relacionada );

CREATE TABLE juego_de_rol.mn_lugares_anecdota ( 
	id_lugar             int UNSIGNED     ,
	id_anecdota          int UNSIGNED     
 );

CREATE INDEX fk_mn_lugares_anecdota_anecdotas ON juego_de_rol.mn_lugares_anecdota ( id_anecdota );

CREATE INDEX fk_mn_lugares_anecdota_lugares ON juego_de_rol.mn_lugares_anecdota ( id_lugar );

CREATE TABLE juego_de_rol.personaje ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	apodo                varchar(100)      ,
	id_raza              int UNSIGNED     ,
	id_trabajo           int UNSIGNED     ,
	edad                 int UNSIGNED     ,
	id_persona           int UNSIGNED     ,
	descripcion          text      ,
	id_fisicas           int UNSIGNED     ,
	id_rol               int UNSIGNED     
 );

CREATE INDEX fk_personaje_caracteristicas_rol ON juego_de_rol.personaje ( id_rol );

CREATE INDEX fk_personaje_carasteristicas_fisicas ON juego_de_rol.personaje ( id_fisicas );

CREATE INDEX fk_personaje_persona ON juego_de_rol.personaje ( id_persona );

CREATE INDEX fk_personaje_raza ON juego_de_rol.personaje ( id_raza );

CREATE INDEX fk_personaje_trabajo ON juego_de_rol.personaje ( id_trabajo );

CREATE TABLE juego_de_rol.relacion ( 
	id_personaje         int UNSIGNED     ,
	id_relacionado       int UNSIGNED     ,
	id_tipo_relacion     int UNSIGNED     
 );

CREATE INDEX fk_mn_personaje_personaje_personaje ON juego_de_rol.relacion ( id_personaje );

CREATE INDEX fk_mn_personaje_personaje_personaje_0 ON juego_de_rol.relacion ( id_relacionado );

CREATE INDEX fk_relacion_tipo_relacion ON juego_de_rol.relacion ( id_tipo_relacion );

CREATE TABLE juego_de_rol.mn_habilidad_personaje ( 
	id_personaje         int UNSIGNED     ,
	id_habilidad         int UNSIGNED     
 );

CREATE INDEX fk_mn_habilidad_personaje_habilidades ON juego_de_rol.mn_habilidad_personaje ( id_habilidad );

CREATE INDEX fk_mn_habilidad_personaje_personaje ON juego_de_rol.mn_habilidad_personaje ( id_personaje );

CREATE TABLE juego_de_rol.mn_personaje_anectdota ( 
	id_anecdota          int UNSIGNED     ,
	id_personaje         int UNSIGNED     
 );

CREATE INDEX fk_mn_personaje_anectdota_anecdotas ON juego_de_rol.mn_personaje_anectdota ( id_anecdota );

CREATE INDEX fk_mn_personaje_anectdota_personaje ON juego_de_rol.mn_personaje_anectdota ( id_personaje );

CREATE TABLE juego_de_rol.mn_personaje_capitulo ( 
	id_capitulo          int UNSIGNED     ,
	id_personaje         int UNSIGNED     
 );

CREATE INDEX fk_mn_personaje_anectdota_personaje_0 ON juego_de_rol.mn_personaje_capitulo ( id_personaje );

CREATE INDEX fk_mn_personaje_capitulo_capitulos ON juego_de_rol.mn_personaje_capitulo ( id_capitulo );

CREATE TABLE rol.capitulos ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	titulo               varchar(150)  NOT NULL    ,
	description          text      ,
	cuando               varchar(100)      ,
	orden                tinyint UNSIGNED     
 );

CREATE TABLE rol.capitulos_cuerpo ( 
	id_capitulo          int UNSIGNED NOT NULL    ,
	id_language          int UNSIGNED NOT NULL    ,
	cuerpo               text      ,
	CONSTRAINT idx_capitulos_cuerpo PRIMARY KEY ( id_capitulo, id_language ),
	CONSTRAINT idx_capitulos_cuerpo_0 PRIMARY KEY ( id_capitulo, id_language )
 ) engine=InnoDB;

CREATE TABLE rol.caracteristicas_rol ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	fuerza               int UNSIGNED     ,
	destreza             int UNSIGNED     ,
	constitucion         int UNSIGNED     ,
	inteligencia         int UNSIGNED     ,
	sabiduria            int UNSIGNED     ,
	carisma              int UNSIGNED     
 ) engine=InnoDB;

CREATE TABLE rol.carasteristicas_fisicas ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	altura               int UNSIGNED     ,
	peso                 int UNSIGNED     ,
	genero               int UNSIGNED  DEFAULT 0   
 ) engine=InnoDB;

ALTER TABLE rol.carasteristicas_fisicas COMMENT 'gasgasf';

ALTER TABLE rol.carasteristicas_fisicas MODIFY genero int UNSIGNED  DEFAULT 0  COMMENT '0 - masculino.\n1 - femenino.\n2 - otros';

CREATE TABLE rol.habilidades ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	descripcion          varchar(250)      
 ) engine=InnoDB;

CREATE TABLE rol.languages ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	code                 varchar(3)  NOT NULL    ,
	label                varchar(100)  NOT NULL    
 ) engine=InnoDB;

CREATE TABLE rol.lugares ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nonbre               varchar(150)  NOT NULL    ,
	descripcion          text      
 ) engine=InnoDB;

CREATE TABLE rol.persona ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	apellidos            varchar(150)  NOT NULL    ,
	apodo                varchar(150)      
 ) engine=InnoDB;

CREATE TABLE rol.raza ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 );

CREATE TABLE rol.tipo_relacion ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 ) engine=InnoDB;

CREATE TABLE rol.trabajo ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 ) engine=InnoDB;

CREATE TABLE rol.anecdotas ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	titulo               varchar(150)  NOT NULL    ,
	description          text      ,
	id_persona           int UNSIGNED     ,
	cuando               varchar(150)      
 ) engine=InnoDB;

CREATE INDEX fk_anecdotas_persona ON rol.anecdotas ( id_persona );

CREATE TABLE rol.mn_anecdota_capitulo ( 
	id_anecdota          int UNSIGNED     ,
	id_capitulo          int UNSIGNED     
 );

CREATE INDEX fk_mn_personaje_anectdota_0_capitulos ON rol.mn_anecdota_capitulo ( id_capitulo );

CREATE INDEX fk_mn_personaje_anectdota_anecdotas_0 ON rol.mn_anecdota_capitulo ( id_anecdota );

CREATE TABLE rol.mn_anecdotas_relacionadas ( 
	id_anecdota          int UNSIGNED     ,
	id_relacionada       int UNSIGNED     
 ) engine=InnoDB;

CREATE INDEX fk_mn_anecdotas_relacionadas_anecdotas ON rol.mn_anecdotas_relacionadas ( id_anecdota );

CREATE INDEX fk_mn_anecdotas_relacionadas_anecdotas_0 ON rol.mn_anecdotas_relacionadas ( id_relacionada );

CREATE TABLE rol.mn_lugares_anecdota ( 
	id_lugar             int UNSIGNED     ,
	id_anecdota          int UNSIGNED     
 ) engine=InnoDB;

CREATE INDEX fk_mn_lugares_anecdota_anecdotas ON rol.mn_lugares_anecdota ( id_anecdota );

CREATE INDEX fk_mn_lugares_anecdota_lugares ON rol.mn_lugares_anecdota ( id_lugar );

CREATE TABLE rol.personaje ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	apodo                varchar(100)      ,
	id_raza              int UNSIGNED     ,
	id_trabajo           int UNSIGNED     ,
	edad                 int UNSIGNED     ,
	id_persona           int UNSIGNED     ,
	descripcion          text      ,
	id_fisicas           int UNSIGNED     ,
	id_rol               int UNSIGNED     
 ) engine=InnoDB;

CREATE INDEX fk_personaje_caracteristicas_rol ON rol.personaje ( id_rol );

CREATE INDEX fk_personaje_carasteristicas_fisicas ON rol.personaje ( id_fisicas );

CREATE INDEX fk_personaje_persona ON rol.personaje ( id_persona );

CREATE INDEX fk_personaje_raza ON rol.personaje ( id_raza );

CREATE INDEX fk_personaje_trabajo ON rol.personaje ( id_trabajo );

CREATE TABLE rol.relacion ( 
	id_personaje         int UNSIGNED     ,
	id_relacionado       int UNSIGNED     ,
	id_tipo_relacion     int UNSIGNED     
 ) engine=InnoDB;

CREATE INDEX fk_mn_personaje_personaje_personaje ON rol.relacion ( id_personaje );

CREATE INDEX fk_mn_personaje_personaje_personaje_0 ON rol.relacion ( id_relacionado );

CREATE INDEX fk_relacion_tipo_relacion ON rol.relacion ( id_tipo_relacion );

CREATE TABLE rol.mn_habilidad_personaje ( 
	id_personaje         int UNSIGNED     ,
	id_habilidad         int UNSIGNED     
 ) engine=InnoDB;

CREATE INDEX fk_mn_habilidad_personaje_habilidades ON rol.mn_habilidad_personaje ( id_habilidad );

CREATE INDEX fk_mn_habilidad_personaje_personaje ON rol.mn_habilidad_personaje ( id_personaje );

CREATE TABLE rol.mn_personaje_anectdota ( 
	id_anecdota          int UNSIGNED     ,
	id_personaje         int UNSIGNED     
 ) engine=InnoDB;

CREATE INDEX fk_mn_personaje_anectdota_anecdotas ON rol.mn_personaje_anectdota ( id_anecdota );

CREATE INDEX fk_mn_personaje_anectdota_personaje ON rol.mn_personaje_anectdota ( id_personaje );

CREATE TABLE rol.mn_personaje_capitulo ( 
	id_capitulo          int UNSIGNED     ,
	id_personaje         int UNSIGNED     
 );

CREATE INDEX fk_mn_personaje_anectdota_personaje_0 ON rol.mn_personaje_capitulo ( id_personaje );

CREATE INDEX fk_mn_personaje_capitulo_capitulos ON rol.mn_personaje_capitulo ( id_capitulo );

CREATE VIEW juego_de_rol.lista_datos_capitulo AS select `c`.`id` AS `id`,`c`.`titulo` AS `titulo`,`c`.`description` AS `description`,`c`.`cuando` AS `cuando`,`c`.`orden` AS `orden`,`cc`.`cuerpo` AS `cuerpo`,`l`.`code` AS `code` from ((`juego_de_rol`.`capitulos` `c` join `juego_de_rol`.`capitulos_cuerpo` `cc` on(`c`.`id` = `cc`.`id_capitulo`)) join `juego_de_rol`.`languages` `l` on(`l`.`id` = `cc`.`id_language`));

CREATE VIEW juego_de_rol.lista_personajes AS select `per`.`id` AS `id`,`per`.`nombre` AS `nombre`,`r`.`nombre` AS `raza`,`p`.`nombre` AS `persona` from ((`juego_de_rol`.`personaje` `per` join `juego_de_rol`.`persona` `p` on(`per`.`id_persona` = `p`.`id`)) join `juego_de_rol`.`raza` `r` on(`per`.`id_raza` = `r`.`id`));

CREATE VIEW juego_de_rol.nextid AS select 1 + max(`juego_de_rol`.`languages`.`id`) AS `next_id` from `juego_de_rol`.`languages`;

ALTER TABLE juego_de_rol.anecdotas ADD CONSTRAINT fk_anecdotas_persona FOREIGN KEY ( id_persona ) REFERENCES juego_de_rol.persona( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.capitulos_cuerpo ADD CONSTRAINT fk_capitulos_cuerpo_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES juego_de_rol.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.capitulos_cuerpo ADD CONSTRAINT fk_capitulos_cuerpo_languages FOREIGN KEY ( id_language ) REFERENCES juego_de_rol.languages( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_anecdota_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_anecdotas_0 FOREIGN KEY ( id_anecdota ) REFERENCES juego_de_rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_anecdota_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_0_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES juego_de_rol.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_anecdotas_relacionadas ADD CONSTRAINT fk_mn_anecdotas_relacionadas_anecdotas FOREIGN KEY ( id_anecdota ) REFERENCES juego_de_rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_anecdotas_relacionadas ADD CONSTRAINT fk_mn_anecdotas_relacionadas_anecdotas_0 FOREIGN KEY ( id_relacionada ) REFERENCES juego_de_rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_habilidad_personaje ADD CONSTRAINT fk_mn_habilidad_personaje_habilidades FOREIGN KEY ( id_habilidad ) REFERENCES juego_de_rol.habilidades( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_habilidad_personaje ADD CONSTRAINT fk_mn_habilidad_personaje_personaje FOREIGN KEY ( id_personaje ) REFERENCES juego_de_rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_lugares_anecdota ADD CONSTRAINT fk_mn_lugares_anecdota_anecdotas FOREIGN KEY ( id_anecdota ) REFERENCES juego_de_rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_lugares_anecdota ADD CONSTRAINT fk_mn_lugares_anecdota_lugares FOREIGN KEY ( id_lugar ) REFERENCES juego_de_rol.lugares( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_personaje_anectdota ADD CONSTRAINT fk_mn_personaje_anectdota_anecdotas FOREIGN KEY ( id_anecdota ) REFERENCES juego_de_rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_personaje_anectdota ADD CONSTRAINT fk_mn_personaje_anectdota_personaje FOREIGN KEY ( id_personaje ) REFERENCES juego_de_rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_personaje_capitulo ADD CONSTRAINT fk_mn_personaje_capitulo_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES juego_de_rol.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.mn_personaje_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_personaje_0 FOREIGN KEY ( id_personaje ) REFERENCES juego_de_rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.personaje ADD CONSTRAINT fk_personaje_caracteristicas_rol FOREIGN KEY ( id_rol ) REFERENCES juego_de_rol.caracteristicas_rol( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.personaje ADD CONSTRAINT fk_personaje_carasteristicas_fisicas FOREIGN KEY ( id_fisicas ) REFERENCES juego_de_rol.carasteristicas_fisicas( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.personaje ADD CONSTRAINT fk_personaje_persona FOREIGN KEY ( id_persona ) REFERENCES juego_de_rol.persona( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.personaje ADD CONSTRAINT fk_personaje_raza FOREIGN KEY ( id_raza ) REFERENCES juego_de_rol.raza( id ) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.personaje ADD CONSTRAINT fk_personaje_trabajo FOREIGN KEY ( id_trabajo ) REFERENCES juego_de_rol.trabajo( id ) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.relacion ADD CONSTRAINT fk_mn_personaje_personaje_personaje FOREIGN KEY ( id_personaje ) REFERENCES juego_de_rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.relacion ADD CONSTRAINT fk_mn_personaje_personaje_personaje_0 FOREIGN KEY ( id_relacionado ) REFERENCES juego_de_rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE juego_de_rol.relacion ADD CONSTRAINT fk_relacion_tipo_relacion FOREIGN KEY ( id_tipo_relacion ) REFERENCES juego_de_rol.tipo_relacion( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.anecdotas ADD CONSTRAINT fk_anecdotas_persona FOREIGN KEY ( id_persona ) REFERENCES rol.persona( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE rol.capitulos_cuerpo ADD CONSTRAINT fk_capitulos_cuerpo_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES rol.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_anecdota_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_anecdotas_0 FOREIGN KEY ( id_anecdota ) REFERENCES rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_anecdota_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_0_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES rol.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_anecdotas_relacionadas ADD CONSTRAINT fk_mn_anecdotas_relacionadas_anecdotas FOREIGN KEY ( id_anecdota ) REFERENCES rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_anecdotas_relacionadas ADD CONSTRAINT fk_mn_anecdotas_relacionadas_anecdotas_0 FOREIGN KEY ( id_relacionada ) REFERENCES rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_habilidad_personaje ADD CONSTRAINT fk_mn_habilidad_personaje_habilidades FOREIGN KEY ( id_habilidad ) REFERENCES rol.habilidades( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_habilidad_personaje ADD CONSTRAINT fk_mn_habilidad_personaje_personaje FOREIGN KEY ( id_personaje ) REFERENCES rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_lugares_anecdota ADD CONSTRAINT fk_mn_lugares_anecdota_lugares FOREIGN KEY ( id_lugar ) REFERENCES rol.lugares( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_lugares_anecdota ADD CONSTRAINT fk_mn_lugares_anecdota_anecdotas FOREIGN KEY ( id_anecdota ) REFERENCES rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_personaje_anectdota ADD CONSTRAINT fk_mn_personaje_anectdota_anecdotas FOREIGN KEY ( id_anecdota ) REFERENCES rol.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_personaje_anectdota ADD CONSTRAINT fk_mn_personaje_anectdota_personaje FOREIGN KEY ( id_personaje ) REFERENCES rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_personaje_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_personaje_0 FOREIGN KEY ( id_personaje ) REFERENCES rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.mn_personaje_capitulo ADD CONSTRAINT fk_mn_personaje_capitulo_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES rol.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.personaje ADD CONSTRAINT fk_personaje_trabajo FOREIGN KEY ( id_trabajo ) REFERENCES rol.trabajo( id ) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE rol.personaje ADD CONSTRAINT fk_personaje_raza FOREIGN KEY ( id_raza ) REFERENCES rol.raza( id ) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE rol.personaje ADD CONSTRAINT fk_personaje_persona FOREIGN KEY ( id_persona ) REFERENCES rol.persona( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE rol.personaje ADD CONSTRAINT fk_personaje_caracteristicas_rol FOREIGN KEY ( id_rol ) REFERENCES rol.caracteristicas_rol( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE rol.personaje ADD CONSTRAINT fk_personaje_carasteristicas_fisicas FOREIGN KEY ( id_fisicas ) REFERENCES rol.carasteristicas_fisicas( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE rol.relacion ADD CONSTRAINT fk_mn_personaje_personaje_personaje FOREIGN KEY ( id_personaje ) REFERENCES rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.relacion ADD CONSTRAINT fk_mn_personaje_personaje_personaje_0 FOREIGN KEY ( id_relacionado ) REFERENCES rol.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE rol.relacion ADD CONSTRAINT fk_relacion_tipo_relacion FOREIGN KEY ( id_tipo_relacion ) REFERENCES rol.tipo_relacion( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

