--------------------------------------------------------Catálogos------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE cestado (--
	idestado bigserial,
	estado varchar(50)
);


CREATE TABLE cmunicipio (--
	idmunicipio bigserial,
	idestado bigint,
	municipio varchar(150)
);

CREATE TABLE cdireccion (--
	iddireccion bigserial,
	colonia varchar(100),
	idmunicipio bigint,
	calle varchar(100),
	numero bigint,
	cp bigint 
);


CREATE TABLE cconsultorio (--
	idconsultorio bigserial,
	iddireccion integer,
	nombre_consultorio varchar(150)
);



CREATE TABLE cgenero (--
	idgenero bigserial,
	genero varchar(100)
);


CREATE TABLE persona (--
	idpersona bigserial,
	correo varchar(100),
	nombre_persona varchar (100),
	app varchar(100),
	apm varchar(100),
	fecha_nacimiento date,
	idgenero integer
);


CREATE TABLE cliente (--
	idcliente bigserial,
	idpersona integer
);



CREATE TABLE cespecialidad (--
	idespecialidad bigserial,
	nombre_especialidad varchar(150)
);


CREATE TABLE cpresentacion(--
	idpresentacion bigserial,
	presentacion VARCHAR (100)
);


CREATE TABLE medico (--
	idmedico bigserial,
	idpersona integer,
	idconsultorio integer
);

CREATE TABLE cmaterial (--
	idmaterial bigserial,
	material varchar(100) 
);


CREATE TABLE proveedor (--
	idproveedor bigserial,
	nombre_proveedor varchar(200)
);


CREATE TABLE cpago (--
	idpago bigserial,
	pago varchar(50)
);


CREATE TABLE farmacia (--
	idfarmacia bigserial,
	nombre_farmacia varchar(100),
	iddireccion integer
);


CREATE TABLE cgama (--
	idgama bigserial,
	gama varchar(10) 
);

CREATE TABLE ccomponente (--
	idcomponente bigserial,
	componente VARCHAR (100), 
	idpresentacion integer,
	idmaterial integer
);

CREATE TABLE medicamento (--
	idmedicamento bigserial,
	caducidad date,
	nombre varchar(100)
);

CREATE TABLE receta (--
	idreceta bigserial,
	fecha date,
	idcliente integer,
	idmedico integer
);


CREATE TABLE medico_cespecialidad (--
	idmedico integer,
	idespecialidad integer,
	idmedicocespecialidad bigserial
);

CREATE TABLE proveedor_cmaterial (--
	idproveedor integer,
	idmaterial integer,
	idproveedor_cmaterial bigserial
);

CREATE TABLE farmacia_receta (--
	idfarm_receta bigserial,
	idfarmacia integer,
	idreceta integer,
	idpago integer,
	cantidad_pesos numeric
);

CREATE TABLE medicamento_receta (--
	idmedicamento integer,
	idreceta integer,
	idventa bigserial,
	unidades_recetadas integer
);

CREATE TABLE medicamento_ccomponente(--
	idmedicamento integer,
	idcomponente integer,
	idmedcomponente bigserial
);


CREATE TABLE medicamento_cgama (--
	idmedicamento_cgama bigserial,
	idgama integer,
	precio bigint,
	idmedicamento integer
);

CREATE TABLE distribucion (--
	cantidad_distribuida bigint,
	idorden bigserial,
	idmedicamento integer,
	idfarmacia integer
);