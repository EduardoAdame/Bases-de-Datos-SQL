----------------------------------------------------------------------------------------------------
										--CATALOGOS--
---------------------------------------------------------------------------------------------------

----------------------------------cestado----------------------------------
ALTER TABLE cestado ADD CONSTRAINT pk_cestado_idestado PRIMARY KEY (idestado);
---------------------------------------------------------------------------

---------------------------------cmunicipio------------------------------------------
ALTER TABLE cmunicipio ALTER COLUMN municipio SET NOT NULL;
ALTER TABLE cmunicipio ADD CONSTRAINT pk_cmunicipio_idmunicipio PRIMARY KEY (idmunicipio);
ALTER TABLE cmunicipio ADD CONSTRAINT fk_cmunicipio_idestado_cestado_idestado FOREIGN KEY(idestado) REFERENCES cestado(idestado) ON DELETE CASCADE;
------------------------------------------------------------------------------------------------------------------

---------------------------------cdireccion---------------------------------------------------------------------------
ALTER TABLE cdireccion ALTER COLUMN calle SET NOT NULL;
ALTER TABLE cdireccion ALTER COLUMN cp SET NOT NULL;
ALTER TABLE cdireccion ADD CONSTRAINT pk_cdireccion_iddireccion PRIMARY KEY (iddireccion);
ALTER TABLE cdireccion ADD CONSTRAINT fk_cdireccion_idmunicipio_cmunicipio_idmunicipio FOREIGN KEY(idmunicipio) REFERENCES cmunicipio(idmunicipio) ON DELETE CASCADE;
------------------------------------------------------------------------------------------------------------------

---------------------------------cconsultorio----------------------------------------------
ALTER TABLE cconsultorio ALTER COLUMN nombre_consultorio SET NOT NULL;
ALTER TABLE cconsultorio ADD CONSTRAINT pk_cconsultorio_idconsultorio PRIMARY KEY (idconsultorio);
ALTER TABLE cconsultorio ADD CONSTRAINT fk_cconsultorio_iddireccion_cdireccion_iddireccion FOREIGN KEY(iddireccion) REFERENCES cdireccion(iddireccion) ON DELETE CASCADE;
------------------------------------------------------------------------------------------------------

--------------------------------cgenero---------------------------------------------------------------
ALTER TABLE cgenero ADD CONSTRAINT chk_cgenero_genero CHECK (genero IN ('HOMBRE', 'MUJER', 'OTROS'));
ALTER TABLE cgenero ALTER COLUMN genero SET NOT NULL;
ALTER TABLE cgenero ADD CONSTRAINT pk_cgenero_idgenero PRIMARY KEY (idgenero);
------------------------------------------------------------------------------------------------------

--------------------------------------persona------------------------------------------------------
ALTER TABLE persona ALTER COLUMN nombre_persona SET NOT NULL;
ALTER TABLE persona ALTER COLUMN app SET NOT NULL;
ALTER TABLE persona ADD CONSTRAINT pk_persona_idpersona PRIMARY KEY (idpersona);
ALTER TABLE persona ADD CONSTRAINT fk_persona_idgenero_cgenero_idgenero FOREIGN KEY(idgenero) REFERENCES cgenero(idgenero) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------

-------------------------------------cliente-------------------------------------------------------------
ALTER TABLE cliente ADD CONSTRAINT pk_cliente_idcliente PRIMARY KEY (idcliente);
ALTER TABLE cliente ADD CONSTRAINT fk_cliente_idpersona_persona_idpersona FOREIGN KEY(idpersona) REFERENCES persona(idpersona) ON DELETE CASCADE;
---------------------------------------------------------------------------------------------------------


--------------------------------cespecialidad---------------------------------------------------------
ALTER TABLE cespecialidad ALTER COLUMN nombre_especialidad SET NOT NULL;
ALTER TABLE cespecialidad ADD CONSTRAINT pk_cespecialidad_idespecialidad PRIMARY KEY (idespecialidad);
-------------------------------------------------------------------------------------------------------


-----------------------------cpresentacion-------------------------------------------------------
ALTER TABLE cpresentacion ADD CONSTRAINT pk_cpresentacion_idpresentacion PRIMARY KEY (idpresentacion);
--------------------------------------------------------------------------------------------------


-------------------------------------medico--------------------------------------------------------------
ALTER TABLE medico ADD CONSTRAINT pk_medico_idmedico PRIMARY KEY (idmedico);
ALTER TABLE medico ADD CONSTRAINT fk_medico_idpersona_persona_idpersona FOREIGN KEY(idpersona) REFERENCES persona(idpersona) ON DELETE CASCADE;
ALTER TABLE medico ADD CONSTRAINT fk_medico_idconsultorio_cconsultorio_idconsultorio FOREIGN KEY(idconsultorio) REFERENCES cconsultorio(idconsultorio) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------


------------------------------cmaterial----------------------------------------------------------
ALTER TABLE cmaterial ADD CONSTRAINT pk_cmaterial_idmaterial PRIMARY KEY (idmaterial);
-------------------------------------------------------------------------------------------------


----------------------------------------proveedor--------------------------------------------------------
ALTER TABLE proveedor ALTER COLUMN nombre_proveedor SET NOT NULL;
ALTER TABLE proveedor ADD CONSTRAINT pk_proveedor_idproveedor PRIMARY KEY (idproveedor);
---------------------------------------------------------------------------------------------------------


--------------------------------cpago-------------------------------------------------------------
ALTER TABLE cpago ADD CONSTRAINT chk_cpago_pago CHECK(pago IN ('EFECTIVO', 'CREDITO', 'DEBITO'));
ALTER TABLE cpago ALTER COLUMN pago SET NOT NULL;
ALTER TABLE cpago ADD CONSTRAINT pk_cpago_idpago PRIMARY KEY (idpago);
--------------------------------------------------------------------------------------------------


-------------------------------------farmacia------------------------------------------------------------
ALTER TABLE farmacia ALTER COLUMN nombre_farmacia SET NOT NULL;
ALTER TABLE farmacia ADD CONSTRAINT pk_farmacia_idfarmacia PRIMARY KEY (idfarmacia);
ALTER TABLE farmacia ADD CONSTRAINT fk_farmacia_iddireccion_cdireccion_iddireccion FOREIGN KEY(iddireccion) REFERENCES cdireccion(iddireccion) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------


-------------------------------cgama--------------------------------------------------------------
ALTER TABLE cgama ADD CONSTRAINT chk_cgama_gama CHECK(gama IN('GENERICO', 'SIMILAR', 'PATENTE'));
ALTER TABLE cgama ADD CONSTRAINT pk_cgama_idgama PRIMARY KEY (idgama);
--------------------------------------------------------------------------------------------------


-----------------------------ccomponente----------------------------------------------------------
ALTER TABLE ccomponente ALTER COLUMN idpresentacion SET NOT NULL;
ALTER TABLE ccomponente ADD CONSTRAINT pk_ccomponente_idcomponente PRIMARY KEY (idcomponente);
ALTER TABLE ccomponente ADD CONSTRAINT fk_ccomponente_idmaterial_cmaterial_idmaterial FOREIGN KEY(idmaterial) REFERENCES cmaterial(idmaterial) ON DELETE CASCADE;
ALTER TABLE ccomponente ADD CONSTRAINT fk_ccomponente_idpresentacion_cpresentacion_idpresentacion FOREIGN KEY(idpresentacion) REFERENCES cpresentacion(idpresentacion) ON DELETE CASCADE;
----------------------------------------------------------------------------------------------------




---------------------------------------medicamento------------------------------------------------------
ALTER TABLE medicamento ADD CONSTRAINT pk_medicamento_idmedicamento PRIMARY KEY(idmedicamento);
ALTER TABLE medicamento ALTER COLUMN caducidad SET NOT NULL;
ALTER TABLE medicamento ALTER COLUMN nombre SET NOT NULL;
--------------------------------------------------------------------------------------------------------


----------------------------------------receta----------------------------------------------------------
ALTER TABLE receta ADD CONSTRAINT pk_receta_idreceta PRIMARY KEY (idreceta);
ALTER TABLE receta ALTER COLUMN fecha SET NOT NULL;
ALTER TABLE receta ADD CONSTRAINT fk_receta_idcliente_cliente_idcliente FOREIGN KEY(idcliente) REFERENCES cliente(idcliente) ON DELETE CASCADE;
ALTER TABLE receta ADD CONSTRAINT fk_receta_idmedico_medico_idmedico FOREIGN KEY(idmedico) REFERENCES medico(idmedico) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------


----------------------------------------medico_cespecialidad--------------------------------------------
ALTER TABLE medico_cespecialidad ADD CONSTRAINT pk_medico_cespecialidad_idmedicocespecialidad PRIMARY KEY(idmedicocespecialidad);
ALTER TABLE medico_cespecialidad ADD CONSTRAINT fk_medico_cespecialidad_idmedico_medico_idmedico FOREIGN KEY(idmedico) REFERENCES medico(idmedico) ON DELETE CASCADE;
ALTER TABLE medico_cespecialidad ADD CONSTRAINT fk_medico_cespecialidad_idespecialidad_cespecialidad_idespecial FOREIGN KEY(idespecialidad) REFERENCES cespecialidad(idespecialidad) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------


----------------------------------------proveedor_cmaterial------------------------------------------------------------------
ALTER TABLE proveedor_cmaterial ADD CONSTRAINT pk_proveedor_cmaterial_idproveedor_cmaterial PRIMARY KEY (idproveedor_cmaterial);
ALTER TABLE proveedor_cmaterial ADD CONSTRAINT fk_proveedor_cmaterial_idproveedor_proveedor_idproveedor FOREIGN KEY (idproveedor) REFERENCES proveedor (idproveedor) ON DELETE CASCADE;
ALTER TABLE proveedor_cmaterial ADD CONSTRAINT fk_proveedor_cmaterial_idmaterial_cmaterial_idmaterial FOREIGN KEY (idmaterial) REFERENCES cmaterial (idmaterial) ON DELETE CASCADE;
-------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------farmacia_receta--------------------------------------------------
ALTER TABLE farmacia_receta ADD CONSTRAINT pk_farmacia_receta_idfarm_receta PRIMARY KEY(idfarm_receta);
ALTER TABLE farmacia_receta ADD CONSTRAINT chk_farmacia_receta_cantidad_pesos CHECK (cantidad_pesos>0);
ALTER TABLE farmacia_receta ALTER COLUMN cantidad_pesos SET NOT NULL;
ALTER TABLE farmacia_receta ADD CONSTRAINT fk_farmacia_receta_idfarmacia_farmacia_idfarmacia FOREIGN KEY(idfarmacia) REFERENCES farmacia(idfarmacia) ON DELETE CASCADE;
ALTER TABLE farmacia_receta ADD CONSTRAINT fk_farmacia_receta_idreceta_receta_idreceta FOREIGN KEY(idreceta) REFERENCES receta(idreceta) ON DELETE CASCADE;
ALTER TABLE farmacia_receta ADD CONSTRAINT fk_farmacia_receta_idpago_cpago_idpago FOREIGN KEY(idpago)REFERENCES cpago(idpago) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------


---------------------------------------medicamento_receta-----------------------------------------------
ALTER TABLE medicamento_receta ADD CONSTRAINT pk_medicamento_receta_idventa PRIMARY KEY(idventa);
ALTER TABLE medicamento_receta ADD CONSTRAINT chk_medicamento_receta_unidades_recetadas CHECK(unidades_recetadas>0);
ALTER TABLE medicamento_receta ALTER COLUMN unidades_recetadas SET NOT NULL;
ALTER TABLE medicamento_receta ADD CONSTRAINT fk_medicamento_receta_idmedicamento_medicamento_idmedicamento FOREIGN KEY(idmedicamento) REFERENCES medicamento(idmedicamento) ON DELETE CASCADE;
ALTER TABLE medicamento_receta ADD CONSTRAINT fk_medicamento_receta_idreceta_receta_idreceta FOREIGN KEY(idreceta) REFERENCES receta(idreceta) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------



----------------------------------------medicamento_ccomponente----------------------------------------
ALTER TABLE medicamento_ccomponente ADD CONSTRAINT pk_medicamento_ccomponente_idmedcomponente PRIMARY KEY(idmedcomponente);
ALTER TABLE medicamento_ccomponente ADD CONSTRAINT fk_medicamento_ccomponente_idmedicamento_medicamento_idmedicame FOREIGN KEY(idmedicamento) REFERENCES medicamento(idmedicamento) ON DELETE CASCADE; 
ALTER TABLE medicamento_ccomponente ADD CONSTRAINT fk_medicamento_ccomponente_idcomponente_ccomponente_idcomponente FOREIGN KEY(idcomponente) REFERENCES ccomponente(idcomponente) ON DELETE CASCADE; 
--------------------------------------------------------------------------------------------------------




----------------------------------------medicamento_cgama------------------------------------------------
ALTER TABLE medicamento_cgama ADD CONSTRAINT pk_medicamento_cgama_idmedicamento_cgama PRIMARY KEY(idmedicamento_cgama);
ALTER TABLE medicamento_cgama ADD CONSTRAINT chk_medicamento_cgama_precio CHECK(precio>0);
ALTER TABLE medicamento_cgama ALTER COLUMN precio SET NOT NULL;
ALTER TABLE medicamento_cgama ADD CONSTRAINT fk_medicamento_cgama_idgama_cgama_idgama FOREIGN KEY(idgama) REFERENCES cgama(idgama) ON DELETE CASCADE;
ALTER TABLE medicamento_cgama ADD CONSTRAINT fk_medicamento_cgama_idmedicamento_medicamento_idmedicame FOREIGN KEY(idmedicamento) REFERENCES medicamento(idmedicamento) ON DELETE CASCADE;
--------------------------------------------------------------------------------------------------------



----------------------------------------distribucion---------------------------------------------------
ALTER TABLE distribucion ADD CONSTRAINT pk_distribucion_idorden PRIMARY KEY(idorden);
ALTER TABLE distribucion ADD CONSTRAINT fk_distribucion_idmedicamento_medicamento_idmedicamento FOREIGN KEY(idmedicamento) REFERENCES medicamento(idmedicamento) ON DELETE CASCADE;
ALTER TABLE distribucion ADD CONSTRAINT fk_distribucion_idfarmacia_farmacia_idfarmacia FOREIGN KEY(idfarmacia) REFERENCES farmacia(idfarmacia) ON DELETE CASCADE;
ALTER TABLE distribucion ADD CONSTRAINT chk_distribucion_cantidad_distribuida CHECK(cantidad_distribuida>0);
ALTER TABLE distribucion ALTER COLUMN cantidad_distribuida SET NOT NULL;
--------------------------------------------------------------------------------------------------------