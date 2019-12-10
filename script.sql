-- -----------------------------------------------------
-- Table dim_loja
-- -----------------------------------------------------
DROP TABLE IF EXISTS dim_loja ;

CREATE TABLE IF NOT EXISTS dim_loja (
  id_loja SERIAL NOT NULL,
  cd_empresa VARCHAR(2) NULL,
  nm_empresa VARCHAR(60) NULL,
  cd_loja VARCHAR(5) NULL,
  ds_loja VARCHAR(30) NULL,
  cd_cep VARCHAR(8) NULL,
  nm_bairro VARCHAR(50) NULL,
  nm_cidade VARCHAR(50) NULL,
  nm_estado VARCHAR(2) NULL,
  PRIMARY KEY (id_loja))
;


-- -----------------------------------------------------
-- Table dim_tempo
-- -----------------------------------------------------
DROP TABLE IF EXISTS dim_tempo ;

CREATE TABLE IF NOT EXISTS dim_tempo (
  id_tempo SERIAL NOT NULL,
  dt_data DATE NULL,
  nr_dia INT NULL,
  nr_mes INT NULL,
  nr_ano INT NULL,
  nr_trimestre INT NULL,
  nr_semestre INT NULL,
  PRIMARY KEY (id_tempo))
;


-- -----------------------------------------------------
-- Table dim_vendedor
-- -----------------------------------------------------
DROP TABLE IF EXISTS dim_vendedor ;

CREATE TABLE IF NOT EXISTS dim_vendedor (
  id_vendedor SERIAL NOT NULL,
  cd_vendedor VARCHAR(5) NULL,
  nm_vendedor VARCHAR(255) NULL,
  ds_sexo CHAR(1) NULL,
  PRIMARY KEY (id_vendedor))
;


-- -----------------------------------------------------
-- Table dim_fatura
-- -----------------------------------------------------
DROP TABLE IF EXISTS dim_fatura ;

CREATE TABLE IF NOT EXISTS dim_fatura (
  id_fatura SERIAL NOT NULL,
  nr_nota VARCHAR(8) NULL,
  ds_status CHAR(1) NULL,
  PRIMARY KEY (id_fatura))
;


-- -----------------------------------------------------
-- Table dim_cliente
-- -----------------------------------------------------
DROP TABLE IF EXISTS dim_cliente ;

CREATE TABLE IF NOT EXISTS dim_cliente (
  id_cliente SERIAL NOT NULL,
  cd_cliente VARCHAR(5) NULL,
  nm_cliente VARCHAR(255) NULL,
  cd_tipo_pessoa CHAR(1) NULL,
  cd_cep VARCHAR(8) NULL,
  nm_bairro VARCHAR(50) NULL,
  nm_cidade VARCHAR(50) NULL,
  nm_estado VARCHAR(2) NULL,
  PRIMARY KEY (id_cliente))
;


-- -----------------------------------------------------
-- Table dim_produto
-- -----------------------------------------------------
DROP TABLE IF EXISTS dim_produto ;

CREATE TABLE IF NOT EXISTS dim_produto (
  id_produto SERIAL NOT NULL,
  cd_produto VARCHAR(10) NULL,
  ds_produto VARCHAR(100) NULL,
  ds_grupo VARCHAR(60) NULL,
  PRIMARY KEY (id_produto))
;


-- -----------------------------------------------------
-- Table fato_venda
-- -----------------------------------------------------
DROP TABLE IF EXISTS fato_venda ;

CREATE TABLE IF NOT EXISTS fato_venda (
  id_fatura INT NOT NULL,
  id_cliente INT NOT NULL,
  id_produto INT NOT NULL,
  id_vendedor INT NOT NULL,
  id_loja INT NOT NULL,
  id_tempo INT NOT NULL,
  vl_venda DOUBLE PRECISION NULL,
  vl_custo DOUBLE PRECISION NULL,
  vl_lucro DOUBLE PRECISION NULL,
  qt_item INT NULL,
  CONSTRAINT fk_fato_venda_dim_fatura
    FOREIGN KEY (id_fatura)
    REFERENCES dim_fatura (id_fatura)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_fato_venda_dim_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES dim_cliente (id_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_fato_venda_dim_produto
    FOREIGN KEY (id_produto)
    REFERENCES dim_produto (id_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_fato_venda_dim_vendedor
    FOREIGN KEY (id_vendedor)
    REFERENCES dim_vendedor (id_vendedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_fato_venda_dim_loja
    FOREIGN KEY (id_loja)
    REFERENCES dim_loja (id_loja)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_fato_venda_dim_tempo
    FOREIGN KEY (id_tempo)
    REFERENCES dim_tempo (id_tempo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_fato_venda_dim_fatura_idx ON fato_venda (id_fatura ASC);

CREATE INDEX fk_fato_venda_dim_cliente1_idx ON fato_venda (id_cliente ASC);

CREATE INDEX fk_fato_venda_dim_produto1_idx ON fato_venda (id_produto ASC);

CREATE INDEX fk_fato_venda_dim_vendedor1_idx ON fato_venda (id_vendedor ASC);

CREATE INDEX fk_fato_venda_dim_loja1_idx ON fato_venda (id_loja ASC);

CREATE INDEX fk_fato_venda_dim_tempo1_idx ON fato_venda (id_tempo ASC);

CREATE UNIQUE INDEX uk_fato_venda ON fato_venda (id_fatura ASC, id_cliente ASC, id_produto ASC, id_vendedor ASC, id_loja ASC, id_tempo ASC);

