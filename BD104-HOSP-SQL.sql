-- Grupo 104 - David Pinto (64609) / Miguel Vieira (64320) / Rodrigo Marques (64411) - FCT NOVA

-- Drops das tabelas existentes
drop table AtosMedicos cascade constraints;

drop table Consultas cascade constraints;

drop table Empregados cascade constraints;

drop table Enfermeiros cascade constraints;

drop table Especialidades cascade constraints;

drop table Farmacos cascade constraints;

drop table Materiais cascade constraints;

drop table Medicos cascade constraints;

drop table Pessoas cascade constraints;

drop table Pulseiras cascade constraints;

drop table Receitas cascade constraints;

drop table Urgencias cascade constraints;

drop table Utentes cascade constraints;

drop table Atendem cascade constraints;

drop table Assistem cascade constraints;

drop table Auxiliam cascade constraints;

drop table Da cascade constraints;

drop table Possuem cascade constraints;

drop table Triagem cascade constraints;

drop table Usam cascade constraints;

drop table Passam cascade constraints;

drop table Consulta_Especialidade cascade constraints;


-- Criacao de Tabelas
-- Cria a tabela da entidade pessoas, generalizacao de Empregados e Utentes.
create table Pessoas (
    NIF number(9, 0),
    Nome varchar2(30),
    Telefone number(12, 0),
    DataDeNascimento date,
    Morada varchar2(255)
);

-- Chave primaria de Pessoas passa a ser (NIF).
alter table Pessoas add constraint pk_pes primary key (NIF);



-- Cria a tabela da entidade empregados, especializacao de Pessoas.
create table Empregados (
    NIF number(9, 0)
);

-- Chave primaria de Empregados passa a ser (NIF).
alter table Empregados add constraint pk_emp primary key (NIF);

-- Chave estrangeira de Empregados em relacao a Pessoas passa a ser a PK de Pessoas.
alter table Empregados add constraint fk_emppes foreign key (NIF) references Pessoas (NIF);



-- Cria a tabela Utentes, especializacao de Pessoas.
create table Utentes (
    NIF number(9, 0),
    NumUtente number(9, 0)
);

-- Chave primaria de Utentes passa a ser (NIF).
alter table Utentes add constraint pk_ute primary key (NIF);

-- Criamos a restricao do NumUtente ser unico na tabela.
alter table Utentes add constraint un_ute unique (NumUtente);

-- Chave estrangeira de Utentes em relacao a Pessoas passa a ser a PK de Pessoas.
alter table Utentes add constraint fk_utepes foreign key (NIF) references Pessoas (NIF);



-- Cria a tabela da entidade Enfermeiros, especializacao de Empregados
create table Enfermeiros (
    NIF number(9, 0),
    IDEnfermeiro number(5, 0)
);

-- Chave primaria de Enfermeiros passa a ser (NIF).
alter table Enfermeiros add constraint pk_enf primary key (NIF);

-- Criamos a restricao do IDEnfermeiro ser unico na tabela.
alter table Enfermeiros add constraint un_enf unique (IDEnfermeiro);

-- Chave estrangeira de Enfermeiros em relacao a Empregados passa a ser a PK de Empregados.
alter table Enfermeiros add constraint fk_enfemp foreign key (NIF) references Empregados (NIF);



-- Cria a tabela da entidade Medicos, especializacao de Empregados.
create table Medicos (
    NIF number(9, 0),
    IDMedico number(5, 0)
);

-- Chave primaria de Medicos passa a ser (NIF).
alter table Medicos add constraint pk_med primary key (NIF);

-- Criamos a restricao do IDMedico ser unico na tabela.
alter table Medicos add constraint un_med unique (IDMedico);

-- Chave estrangeira de Medicos em relacao a Empregados passa a ser a PK de Empregados.
alter table Medicos add constraint fk_medemp foreign key (NIF) references Empregados (NIF);



-- Cria a tabela da entidade Especialidades.
create table Especialidades (
    NomeEspecialidade varchar2(45),
    DescricaoEsp varchar2(1000)
);

-- Chave primaria de Especialidades passa a ser (NomeEspecialidade).
alter table Especialidades add constraint pk_esp primary key (NomeEspecialidade);



-- Cria a tabela da relacao Da, entre Medicos e Especialidades.
create table Da (
    NIF number(9, 0),
    NomeEspecialidade varchar2(45)
);

-- Chave primaria de Da passa a ser (NIF, NomeEspecialidade).
alter table Da add constraint pk_da primary key (NIF, NomeEspecialidade);

-- Chave estrangeira de Da em relacao a Medicos passa a ser a PK de Medicos.
alter table Da add constraint fk_damed foreign key (NIF) references Medicos (NIF);

-- Chave estrangeira de Da em relacao a Especialidades passa a ser a PK de Especialidades.
alter table Da add constraint fk_daesp foreign key (NomeEspecialidade) references Especialidades (NomeEspecialidade);



-- Cria a tabela da entidade fraca AtosMedicos que se relaciona com Utentes.
create table AtosMedicos (
    NIF number(9, 0),
    DataAto date
);

-- Chave primaria de AtosMedicos passa a ser o tuplo (NIF, DataAto).
alter table AtosMedicos add constraint pk_ato primary key (NIF, DataAto);

-- Chave estrangeira de AtosMedicos em relacao a Utentes passa a ser a PK de Utentes.
alter table AtosMedicos add constraint fk_atoute foreign key (NIF) references Utentes (NIF);



-- Cria a tabela da entidade Consultas, especializacao de AtosMedicos.
create table Consultas (
    NIF number(9, 0),
    DataConsulta date
);

-- Chave primaria de Consultas passa a ser o tuplo (NIF, DataConsulta).
alter table Consultas add constraint pk_con primary key (NIF, DataConsulta);

-- Chave estrangeira de Consultas em relacao a AtosMedicos passa a ser a PK de AtosMedicos.
alter table Consultas add constraint fk_conato foreign key (NIF, DataConsulta) references AtosMedicos (NIF, DataAto);



-- Cria a tabela da entidade Urgencias, especializacao de AtosMedicos.
create table Urgencias (
    NIF number(9, 0),
    DataEntrada date,
    DataSaida date
);

-- Chave primaria de Urgencias passa a ser (NIF, DataEntrada).
alter table Urgencias add constraint pk_urg primary key (NIF, DataEntrada);

-- Chave estrangeira de Urgencias em relacao a AtosMedicos passa a ser a PK de AtosMedicos (NIF, DataAto).
alter table Urgencias add constraint fk_urgato foreign key (NIF, DataEntrada) references AtosMedicos(NIF, DataAto);



-- Cria a tabela da relação Atendem, entre AtosMedicos e Medicos.
create table Atendem (
    UtenteNIF number(9, 0),
    MedicoNIF number(9, 0),
    DataAto date
);

-- Chave primaria passa a ser (UtenteNIF, DataAto).
alter table Atendem add constraint pk_ate primary key (UtenteNIF, DataAto);

-- Chave estrangeira de Atendem em relacao a AtosMedicos passa a ser a PK de AtosMedicos.
alter table Atendem add constraint fk_ateato foreign key (UtenteNIF, DataAto) references AtosMedicos (NIF, DataAto);

-- Chave estrangeira de Atendem em relacao a Medicos passa a ser a PK de Medicos.
alter table Atendem add constraint fk_atemed foreign key (MedicoNIF) references Medicos (NIF);



-- Cria a tabela da relacao Assistem, entre Enfermeiros e Consultas.
create table Assistem (
    EnfermeiroNIF number(9, 0),
    UtenteNIF number(9, 0),
    DataEntrada date
);

-- Chave primaria de Assistem passa a ser (EnfermeiroNIF, UtenteNIF, DataEntrada).
alter table Assistem add constraint pk_ass primary key (UtenteNIF, DataEntrada);

-- Chave estrangeira de Assistem em relacao a Enfermeiros passa a ser a PK de Enfermeiros.
alter table Assistem add constraint fk_assenf foreign key (EnfermeiroNIF) references Enfermeiros (NIF);

-- Chave estrangeira de Assistem em relacao a Urgencias passa a ser a PK de Urgencias.
alter table Assistem add constraint fk_asscon foreign key (UtenteNIF, DataEntrada) references Urgencias (NIF, DataEntrada);



-- Cria a tabela da relacao Auxiliam, entre Enfermeiros e Urgencias.
create table Auxiliam (
    EnfermeiroNIF number(9, 0),
    UtenteNIF number(9, 0),
    DataEntrada date
);

-- Chave primaria de Auxiliam passa a ser (EnfermeiroNIF, UtenteNIF, DataEntrada).
alter table Auxiliam add constraint pk_aux primary key (EnfermeiroNIF, UtenteNIF, DataEntrada);

-- Chave estrangeira de Auxiliam em relacao a Enfermeiros passa a ser a PK de Enfermeiros.
alter table Auxiliam add constraint fk_auxenf foreign key (EnfermeiroNIF) references Enfermeiros (NIF);

-- Chave estrangeira de Auxiliam em relacao a Urgencias passa a ser a PK de Urgencias.
alter table Auxiliam add constraint fk_auxurg foreign key (UtenteNIF, DataEntrada) references Urgencias (NIF, DataEntrada);



-- Cria a tabela da entidade Pulseiras.
create table Pulseiras (
    Cor varchar2(10),
    DescricaoPul varchar2(255)
);

-- Chave primaria de Pulseiras passa a ser (Cor).
alter table Pulseiras add constraint pk_pul primary key (Cor);



-- Cria a tabela da relacao Triagem, entre Urgencias e Pulseiras.
create table Triagem (
    NIF number(9, 0),
    DataUrgencia date,
    DataTriagem date,
    Cor varchar2(10)
);

-- Chave primaria de Triagem passa a ser (NIF, DataUrgencia).
alter table Triagem add constraint pk_tri primary key (NIF, DataUrgencia);

-- Chave estrangeira de Triagem em relacao a Urgencias passa a ser a PK de Urgencias.
alter table Triagem add constraint fk_triurg foreign key (NIF, DataUrgencia) references Urgencias (NIF, DataEntrada);

-- Chave estrangeira de Triagem em relacao a Pulseiras passa a ser PK de Pulseiras.
alter table Triagem add constraint fk_tripul foreign key (Cor) references Pulseiras (Cor);



-- Cria a tabela da entidade Materiais.
create table Materiais (
    CodProduto number(5, 0),
    NomeProduto varchar2(30),
    DescricaoProduto varchar2(255),
    Classe varchar2(30),
    Stock number(5, 0)
);

-- Chave primaria de Materiais passa a ser (CodProduto).
alter table Materiais add constraint pk_mat primary key (CodProduto);



-- cria a tabela da relacao Usam, entre AtosMedicos e Material.
create table Usam (
    NIF number(9, 0),
    DataAto date,
    CodProduto number(5, 0),
    Quantidade number(5, 0)
);

-- Chave primaria de Usam passa a ser (NIF, DataAto, CodProduto).
alter table Usam add constraint pk_usa primary key (NIF, DataAto, CodProduto);

-- Chave estrangeira de Usam em relacao a AtosMedicos passa a ser a PK de AtosMedicos.
alter table Usam add constraint fk_usaato foreign key (NIF, DataAto) references AtosMedicos (NIF, DataAto);

-- Chave estrangeira de Usam em relacao a Materiais passa a ser a PK de Materiais.
alter table Usam add constraint fk_usamat foreign key (CodProduto) references Materiais (CodProduto);



-- Cria a tabela da entidade Farmacos.
create table Farmacos (
    PrincipioAtivo varchar2(120),
    Dosagem varchar2(45),
    Preco number(10, 2),
    FormaFarmaco varchar2(90),
    Unidades varchar2(30)
);

-- Chave primaria de Farmacos passa a ser (PrincipioAtivo, Dosagem, FormaFarmaco, Unidades).
alter table Farmacos add constraint pk_far primary key (PrincipioAtivo, Dosagem, FormaFarmaco, Unidades);



-- Cria a tabela da entidade Receitas.
create table Receitas (
    NumReceita number(9, 0),
    DataReceita date
);

-- Chave primaria de Receitas passa a ser (NumReceita).
alter table Receitas add constraint pk_rec primary key (NumReceita);



-- Cria a tabela da relacao Possuem, entre Receitas e Farmacos.
create table Possuem (
    NumReceita number(9, 0),
    PrincipioAtivo varchar2(120),
    Dosagem varchar2(45),
    FormaFarmaco varchar2(90),
    Unidades varchar2(30),
    Posologia varchar2(255),
    Quantidade number(1, 0),
    Validade date
);

-- Chave primaria de Possuem passa a ser (NumReceita, PrincipioAtivo, Dosagem, FormaFarmaco, Unidades).
alter table Possuem add constraint pk_pos primary key (NumReceita, PrincipioAtivo, Dosagem, FormaFarmaco, Unidades);

-- Chave estrangeira de Possuem em relacao a Receitas passa a ser a PK de Receitas.
alter table Possuem add constraint fk_posrec foreign key (NumReceita) references Receitas (NumReceita);

-- Chave estrangeira de Possuem em relacao a Farmacos passa a ser a PK de Farmacos.
alter table Possuem add constraint fk_posfar foreign key (PrincipioAtivo, Dosagem, FormaFarmaco, Unidades) references Farmacos (PrincipioAtivo, Dosagem, FormaFarmaco, Unidades);


-- Cria a tabela da relação Passam, entre Receitas e AtosMédicos
create table Passam
(
    DataAto date,
    NIF number(9,0),
    NumReceita number (9,0)
);

-- Chave primária de Passam passa a ser (NIF, NumReceita, DataAto)
alter table Passam add constraint pk_pas primary key (NIF,NumReceita, DataAto);

-- Chave Estrangeira de Passam relacionada com Receitas através da chave primária (NumReceita)
alter table Passam add constraint fk_pasRec foreign key (NumReceita) REFERENCES RECEITAS (NumReceita);

-- Chave Estrangeira de Passam relacionada com AtosMédicos através das chaves primárias (NIF,DataAto)
alter table Passam add constraint fk_pasAto foreign key (NIF,DataAto) REFERENCES AtosMedicos(NIF,DataAto);


-- Cria a tabela de relação Consulta-Especialidade, entre Consultas e Especialidades
create table Consulta_Especialidade
(
    NIF number(9,0),
    DataConsulta date,
    NomeEspecialidade varchar2(45)
);

-- Chave primária de Consulta-Especialidade passa a ser (NIF, DataConsulta)
alter table Consulta_Especialidade add constraint pk_conesp primary key (NIF, DataConsulta);

-- Chave estrangeira de Consulta-Especialidade com Consultas atráves da chaves primárias (NIF, DataConsulta)
alter table Consulta_Especialidade add constraint fk_conespcon foreign key (NIF,DataConsulta) references Consultas(NIF, DataConsulta) ;

-- Chave estrangeira de Consulta-Especialidade com Especialidades através da chave primária (NomeEspecialidade)
alter table Consulta_Especialidade add constraint fk_conespesp foreign key (NomeEspecialidade) references Especialidades(NomeEspecialidade);


commit;

-- Sequencias e triggers
-- sequecia de ids medicos e enfermeiros
drop sequence seq_num_id;
create sequence seq_num_id
start with 10000
increment by 1;
commit;


-- sequencia de codigos de produtos
drop sequence seq_num_produto;
create sequence seq_num_produto
start with 1
increment by 1;
commit;


-- sequencia de numeros de receita
drop sequence seq_num_receita;
create sequence seq_num_receita
start with 300000000
increment by 1;
commit;


-- trigger de verificação se o doente não é tratado pela propria pessoa
create or replace trigger verifica_pessoa
    after insert or update on Atendem
    declare count_NIF number;
    begin
        select count(*) into count_NIF from Atendem
            where UtenteNIF = MedicoNIF;
        IF count_NIF > 0
            then Raise_Application_Error (-20100, 'Erro: Não se pode por o utente a ser curado pela própria pessoa');
        end if;
    end;
/

commit;


-- trigger que quando inserir-mos informação da consulta associa automaticamente nos atos
create or replace trigger associar_consulta_ato
    after insert on Consultas
    for each row
    begin
        insert into AtosMedicos (NIF, DataAto)
            values (:new.NIF, :new.DataConsulta);
    end;
/
commit;


-- trigger que quando inserir-mos informação da urgencia associa automaticamente nos atos
create or replace trigger associar_urgencia_ato
    after insert on Urgencias
    for each row
    begin
        insert into AtosMedicos (NIF, DataAto)
            values (:new.NIF, :new.DataEntrada);
    end;
/
commit;


-- trigger que quando inserir-mos informação nos Médicos associa automaticamente nos Empregados
create or replace trigger associar_medico_emp
    after insert or update on Medicos
    for each row
    begin
        insert into Empregados (NIF)
        values (:new.NIF);
    end;
/
commit;


-- trigger que quando inserir-mos informação nos Enfermeiros associa automaticamente nos Empregados
create or replace trigger associar_enfermeiro_emp
    after insert or update on Enfermeiros
    for each row
    begin
        insert into Empregados (NIF)
        values (:new.NIF);
    end;
/
commit;

delete from Farmacos;

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Abiraterona', '250 mg', 3183.92, 'Comprimido', '120 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acamprosato', '333 mg', 10.37, 'Comprimido gastrorresistente', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acamprosato', '333 mg', 3.19, 'Comprimido gastrorresistente', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '50 mg', 4.32, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '100 mg', 3.53, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '100 mg', 2.34, 'Comprimido', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '50 mg', 2.24, 'Comprimido', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '50 mg', 0.35, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '100 mg', 0.29, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '100 mg', 0.13, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acarbose', '50 mg', 0, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceclofenac', '100 mg', 4.95, 'Comprimido revestido por película', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceclofenac', '100 mg', 4.35, 'Comprimido revestido por película', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceclofenac', '100 mg', 2.83, 'Pó para suspensão oral', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceclofenac', '100 mg', 2.57, 'Comprimido revestido por película', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceclofenac', '100 mg', 2.3, 'Comprimido revestido por película', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceclofenac', '15 mg/g', NULL, 'Creme', '1 unidade(s) - 100 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceglumato de deanol + Heptaminol', '230 mg/10 ml + 180 mg/10 ml', 11.52, 'Solução oral', '20 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acemetacina', '90 mg', 36.56, 'Cápsula de libertação prolongada', '90 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acemetacina', '60 mg', 23.7, 'Cápsula', '90 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acemetacina', '90 mg', 14.53, 'Cápsula de libertação prolongada', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acemetacina', '90 mg', 13.03, 'Cápsula de libertação prolongada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acemetacina', '60 mg', 10.61, 'Cápsula', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acemetacina', '60 mg', 6.1, 'Cápsula', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acemetacina', '60 mg', 3.19, 'Cápsula', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acenocumarol', '4 mg', 9.97, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acenocumarol', '4 mg', 1.47, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceponato de metilprednisolona', '1 mg/g', 6.02, 'Emulsão cutânea', '1 unidade(s) - 50 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceponato de metilprednisolona', '1 mg/g', 4.58, 'Emulsão cutânea', '1 unidade(s) - 20 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceponato de metilprednisolona', '1 mg/g', 3.47, 'Pomada', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aceponato de metilprednisolona', '1 mg/g', 3.41, 'Creme', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de cálcio + Carbonato de magnésio', '435 mg + 235 mg', 34.73, 'Comprimido revestido por película', '180 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de eslicarbazepina', '800 mg', 99.25, 'Comprimido', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de eslicarbazepina', '800 mg', 96.64, 'Comprimido', '60 unidade(s) - 800 mg');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de eslicarbazepina', '800 mg', 52.24, 'Comprimido', '30 unidade(s) - 800 mg');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de eslicarbazepina', '200 mg', 52, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de eslicarbazepina', '200 mg', 20.25, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de eslicarbazepina', '800 mg', 11.14, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de eslicarbazepina', '800 mg', 5.13, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de glatirâmero', '40 mg/ml', 716.91, 'Solução injetável em seringa pré-cheia', '12 unidade(s) - 1 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetato de glatirâmero', '20 mg/1 ml', 701.13, 'Solução injetável', '28 unidade(s) - 1 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetazolamida', '250 mg', 1.12, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetazolamida', '250 mg', 0.59, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '200 mg/ml', 16.91, 'Concentrado para solução para perfusão', '1 unidade(s) - 25 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '300 mg/3 ml', 3.01, 'Solução injetável', '5 unidade(s) - 3 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '20 mg/ml', NULL, 'Solução oral', '1 unidade(s) - 200 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '40 mg/ml', NULL, 'Solução oral', '1 unidade(s) - 200 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '200 mg', NULL, 'Comprimido efervescente', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '200 mg', NULL, 'Granulado para solução oral', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '600 mg', NULL, 'Comprimido efervescente', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '20 mg/ml', NULL, 'Solução oral', '1 unidade(s) - 100 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '40 mg/ml', NULL, 'Solução oral', '1 unidade(s) - 100 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '600 mg', NULL, 'Comprimido efervescente', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '200 mg', NULL, 'Comprimido efervescente', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '200 mg', NULL, 'Comprimido efervescente', '25 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilcisteína', '600 mg', NULL, 'Comprimido efervescente', '25 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilsalicilato de lisina', '180 mg', 1.47, 'Pó para solução oral', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilsalicilato de lisina', '1800 mg', NULL, 'Pó para solução oral', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetilsalicilato de lisina', '900 mg', NULL, 'Pó para solução oral', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona', '0.1 mg/0.4 ml', 13.33, 'Gotas auriculares, solução em recipiente unidose', '30 unidade(s) - .4 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona', '0.25 mg/g', 2.66, 'Creme', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Ciprofloxacina', 'Associação', 16.13, 'Gotas auriculares, solução em recipiente unidose', '15 unidade(s) - .25 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Ciprofloxacina', '0.25 mg/ml + 3 mg/ml', 9.48, 'Gotas auriculares, solução', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Lidocaína + Subgalhato de bismuto', 'Associação', 13.96, 'Pomada retal', '1 unidade(s) - 40 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Lidocaína + Subgalhato de bismuto', 'Associação', 5.38, 'Pomada retal', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Neomicina', '3.5 mg + 0.25 mg', 13.96, 'Creme', '1 unidade(s) - 40 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Neomicina', '3.5 mg + 0.25 mg', 5.38, 'Creme', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Neomicina + Polimixina B', 'Associação', 7.3, 'Gotas auriculares, solução', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acetonido de fluocinolona + Neomicina + Polimixina B', 'Associação', 2.31, 'Gotas auriculares, solução', '1 unidade(s) - 5 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '800 mg', 69.33, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '250 mg', 43.85, 'Pó para solução para perfusão', '5 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '400 mg', 35.75, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '30 mg/g', 32.9, 'Pomada oftálmica', '1 unidade(s) - 4.5 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '800 mg', 31.72, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '250 mg', 26.29, 'Pó para solução para perfusão', '3 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '800 mg', 25.96, 'Comprimido', '25 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '200 mg', 19.93, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '400 mg', 15.46, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '400 mg', 11.11, 'Comprimido', '25 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '200 mg', 10.69, 'Comprimido', '25 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '80 mg/ml', 10.27, 'Suspensão oral', '1 unidade(s) - 200 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '250 mg', 10.06, 'Pó para solução para perfusão', '1 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '800 mg', 5.2, 'Comprimido dispersível', '25 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '800 mg', 4.35, 'Comprimido dispersível', '35 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '80 mg/ml', 4.04, 'Suspensão oral', '1 unidade(s) - 100 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '800 mg', 2.34, 'Comprimido', '35 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Gel', '1 unidade(s) - 2 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Gel', '1 unidade(s) - 5 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Gel', '1 unidade(s) - 15 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Creme', '1 unidade(s) - 15 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Creme', '1 unidade(s) - 10 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Creme', '1 unidade(s) - 2 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Creme', '1 unidade(s) - 3 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Creme', '1 unidade(s) - 5 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir', '50 mg/g', NULL, 'Lápis cutâneo', '1 unidade(s) - 5 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aciclovir + Hidrocortisona', '50 mg/g + 10 mg/g', NULL, 'Creme', '1 unidade(s) - 2 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido 5-aminolevulínico', '8 mg', 216.07, 'Emplastro medicamentoso', '8 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido 5-aminolevulínico', '8 mg', 84.56, 'Emplastro medicamentoso', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '150 mg', 5.06, 'Comprimido gastrorresistente', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 4.88, 'Comprimido revestido por película', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 4.77, 'Comprimido gastrorresistente', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 4.37, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 4.22, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 4.04, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 3.74, 'Comprimido gastrorresistente', '56 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '150 mg', 3.72, 'Comprimido', '40 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '150 mg', 3.45, 'Comprimido', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 2.48, 'Comprimido gastrorresistente', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 2.38, 'Comprimido gastrorresistente', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '150 mg', 2.35, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 2.32, 'Comprimido revestido por película', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '100 mg', 2.11, 'Comprimido', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '150 mg', 0.84, 'Cápsula de libertação modificada', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Granulado', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '1000 mg', NULL, 'Comprimido revestido', '8 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '1000 mg', NULL, 'Comprimido revestido', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '1000 mg', NULL, 'Comprimido revestido', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido revestido', '8 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido efervescente', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido efervescente', '24 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido revestido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido revestido', '40 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido revestido', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '40 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '100 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico', '500 mg', NULL, 'Comprimido', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Ácido ascórbico', '400 mg + 240 mg', NULL, 'Comprimido efervescente', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Ácido ascórbico + Cafeína', '500 mg + 100 mg + 50 mg', NULL, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 40 mg + 10 mg', 14.87, 'Cápsula', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 40 mg + 5 mg', 13.1, 'Cápsula', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 20 mg + 10 mg', 11.93, 'Cápsula', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 40 mg + 2.5 mg', 11.9, 'Cápsula', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 40 mg + 2.5 mg', 9.94, 'Cápsula', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 20 mg + 5 mg', 8.96, 'Cápsula', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 20 mg + 2.5 mg', 7.86, 'Cápsula', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Atorvastatina + Ramipril', '100 mg + 20 mg + 2.5 mg', 6.11, 'Cápsula', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Cafeína', '500 mg + 30 mg', NULL, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Cafeína', '500 mg + 30 mg', NULL, 'Comprimido', '250 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Paracetamol + Ácido ascórbico', '300 mg + 200 mg + 300 mg', NULL, 'Comprimido efervescente', '16 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Paracetamol + Cafeína', '250 mg + 250 mg + 65 mg', NULL, 'Comprimido revestido por película', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Paracetamol + Cafeína', '250 mg + 250 mg + 65 mg', NULL, 'Comprimido revestido por película', '16 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Paracetamol + Cafeína', '250 mg + 250 mg + 65 mg', NULL, 'Comprimido revestido por película', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Pseudoefedrina', '500 mg + 30 mg', NULL, 'Granulado para suspensão oral', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido acetilsalicílico + Pseudoefedrina', '500 mg + 30 mg', NULL, 'Granulado para suspensão oral', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 75.96, 'Comprimido revestido por película', '40 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 75.96, 'Comprimido', '40 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 21.73, 'Comprimido', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '10 mg', 21.23, 'Comprimido', '56 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 16.71, 'Comprimido', '8 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 13.9, 'Comprimido revestido por película', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 11.54, 'Comprimido', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '10 mg', 11.41, 'Comprimido', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 9.78, 'Comprimido revestido por película', '8 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '10 mg', 5.58, 'Comprimido', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 4.39, 'Comprimido revestido por película', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg/100 ml', 4.37, 'Solução oral', '4 unidade(s) - 100 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 4.32, 'Comprimido revestido por película', '2 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 4.32, 'Comprimido', '2 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico', '70 mg', 4.21, 'Comprimido efervescente', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico + Colecalciferol', '70 mg + 2800 U.I.', 9.97, 'Comprimido', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido alendrónico + Colecalciferol', '70 mg + 5600 U.I.', 4.35, 'Comprimido', '4 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido aminocapróico', '3000 mg', 12.08, 'Pó para solução oral', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido aminocapróico', '2500 mg/10 ml', 9.97, 'Solução para perfusão', '6 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ascórbico', '1000 mg', NULL, 'Granulado', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ascórbico', '1000 mg', NULL, 'Granulado', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ascórbico', '100 mg/ml', NULL, 'Gotas orais, solução', '1 unidade(s) - 20 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ascórbico', '1000 mg', NULL, 'Comprimido efervescente', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ascórbico', '1000 mg', NULL, 'Comprimido efervescente', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ascórbico', '500 mg', NULL, 'Cápsula', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ascórbico', '500 mg', NULL, 'Cápsula', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido azelaico', '150 mg/g', 15.86, 'Gel', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido azelaico', '200 mg/g', NULL, 'Creme', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido azelaico', '200 mg/g', NULL, 'Creme', '1 unidade(s) - 50 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido azelaico', '200 mg/g', NULL, 'Creme', '1 unidade(s) - 20 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido bempedoico', '180 mg', 85.76, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido bempedoico + Ezetimiba', '180 mg + 10 mg', 85.76, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cítrico + Citrato de potássio + Citrato de sódio', '145 mg/g + 463 mg/g + 390 mg/g', 7.31, 'Granulado', '1 unidade(s) - 280 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cítrico + Óxido de magnésio + Picossulfato de sódio', '10.97 g + 3.5 g + 0.01 g', 187.27, 'Pó para solução oral', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cítrico + Óxido de magnésio + Picossulfato de sódio', '10.97 g + 3.5 g + 0.01 g', 17.45, 'Pó para solução oral', '2 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cítrico + Óxido de magnésio + Picossulfato de sódio', '12 g + 3.5 g + 0.01 g', 12.54, 'Pó para solução oral', '2 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cromoglícico', '20 mg/ml', NULL, 'Colírio, solução', '20 unidade(s) - .3 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cromoglícico', '20 mg/ml', NULL, 'Colírio, solução', '10 unidade(s) - .3 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cromoglícico', '20 mg/ml', NULL, 'Colírio, solução', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cromoglícico', '20 mg/ml', NULL, 'Solução para inalação por nebulização', '1 unidade(s) - 15 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido cromoglícico', '20 mg/ml', NULL, 'Colírio, solução', '1 unidade(s) - 5 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido desoxicólico', '10 mg/ml', 964, 'Solução injetável', '4 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido espaglúmico', '49 mg/ml', 4.66, 'Colírio, solução', '1 unidade(s) - 5 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido espaglúmico', '49 mg/ml', 3.89, 'Colírio, solução', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido flufenâmico + Heparinóide', '30 mg/g + 2 mg/g', NULL, 'Creme', '1 unidade(s) - 100 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '400 µg', 11.98, 'Comprimido', '120 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '1 mg', 9.07, 'Comprimido', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '5 mg', 6.6, 'Comprimido', '84 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '400 µg', 5.68, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '5 mg', 3.5, 'Comprimido', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '5 mg', 3.09, 'Comprimido', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '5 mg', 2.97, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '5 mg', 2.97, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '400 µg', 2.57, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '5 mg', 1.33, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico', '400 µg', NULL, 'Comprimido', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina', '0.4 mg + 0.002 mg', NULL, 'Comprimido', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina', '0.4 mg + 0.002 mg', NULL, 'Comprimido', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina', '0.4 mg + 0.002 mg', NULL, 'Comprimido', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina', '0.4 mg + 0.002 mg', NULL, 'Comprimido', '56 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina', '0.4 mg + 0.002 mg', NULL, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina + Iodo', '0.4 mg + 0.002 mg + 0.2 mg', NULL, 'Comprimido', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina + Iodo', '0.4 mg + 0.002 mg + 0.2 mg', NULL, 'Comprimido', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina + Iodo', '0.4 mg + 0.002 mg + 0.2 mg', NULL, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina + Iodo', '0.4 mg + 0.002 mg + 0.2 mg', NULL, 'Comprimido', '56 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Cianocobalamina + Iodo', '0.4 mg + 0.002 mg + 0.2 mg', NULL, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Complexo hidróxido férrico-polimaltose', '0.35 mg + 357 mg', 5.86, 'Comprimido para mastigar', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Complexo hidróxido férrico-polimaltose', '0.35 mg + 357 mg', 2.7, 'Comprimido para mastigar', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Ferro', '1 mg + 90 mg', 8.27, 'Comprimido revestido por película', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fólico + Ferro', '1 mg + 90 mg', 3.19, 'Comprimido revestido por película', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '250 mg', 4.91, 'Comprimido revestido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '10 mg/g', 2.8, 'Gel oftálmico', '1 unidade(s) - 5 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '20 mg/g', NULL, 'Creme', '1 unidade(s) - 15 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '20 mg/g', NULL, 'Creme', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '20 mg/g', NULL, 'Creme', '1 unidade(s) - 20 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '20 mg/g', NULL, 'Pomada', '1 unidade(s) - 15 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '20 mg/g', NULL, 'Pomada', '1 unidade(s) - 20 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido fusídico', '20 mg/g', NULL, 'Pomada', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 

VALUES ('Ácido fusídico', '20 mg/g', NULL, 'Creme', '20 unidade(s) - 15 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido hialurónico', '20 mg/2 ml', 38.57, 'Solução injetável', '1 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ibandrónico', '3 mg/3 ml', 68.31, 'Solução injetável', '1 unidade(s) - 3 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ibandrónico', '150 mg', 41.59, 'Comprimido revestido por película', '3 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ibandrónico', '150 mg', 4.53, 'Comprimido revestido por película', '1 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ibandrónico + Colecalciferol', '150 mg + 22400 U.I.', 18.91, 'Comprimido revestido por película', '3 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ibandrónico + Colecalciferol', '150 mg + 22400 U.I.', 6.3, 'Comprimido revestido por película', '1 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido micofenólico', '360 mg', 206, 'Comprimido gastrorresistente', '120 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido micofenólico', '180 mg', 111.85, 'Comprimido gastrorresistente', '120 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido quenodesoxicólico', '250 mg', 6.01, 'Cápsula', '40 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido quenodesoxicólico', '125 mg', 5.06, 'Cápsula', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido quenodesoxicólico', '250 mg', 5.06, 'Cápsula', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido quenodesoxicólico', '125 mg', 4.3, 'Cápsula', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico', '100 mg/ml', NULL, 'Solução cutânea', '1 unidade(s) - 15 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico', '270 mg/g', NULL, 'Pomada', '1 unidade(s) - 5 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico', '83 mg/ml', NULL, 'Solução cutânea', '1 unidade(s) - 15 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico', '167 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Ácido láctico', '193 mg/ml + 232 mg/ml', NULL, 'Solução cutânea', '1 unidade(s) - 12 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Fluorouracilo', '100 mg/g + 5 mg/g', 29.28, 'Solução cutânea', '1 unidade(s) - 25 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Fluorouracilo', '100 mg/ml + 5 mg/ml', NULL, 'Solução cutânea', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Fluorouracilo', '100 mg/ml + 5 mg/ml', NULL, 'Solução cutânea', '1 unidade(s) - 20 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Fluorouracilo', '100 mg/ml + 5 mg/ml', NULL, 'Solução cutânea', '1 unidade(s) - 13 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Heparinóide', '2 mg/g + 20 mg/g', 6.41, 'Creme', '1 unidade(s) - 100 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Heparinóide', '2 mg/g + 20 mg/g', 6.41, 'Gel', '1 unidade(s) - 100 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Mentol + Nicotinato de benzilo', '65 mg/g + 5 mg/g + 10 mg/g', NULL, 'Creme', '1 unidade(s) - 40 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Ruibarbo', '10 mg/ml + 50 mg/ml', NULL, 'Solução bucal', '1 unidade(s) - 30 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Ruibarbo', '10 mg/ml + 50 mg/ml', NULL, 'Solução bucal', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido salicílico + Salicilato de metilo + Capsaícina + Mentol', 'Associação', NULL, 'Pomada', '1 unidade(s) - 40 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido tranexâmico', '500 mg', 5.34, 'Comprimido revestido por película', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido tranexâmico', '500 mg', 4.6, 'Comprimido revestido por película', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ursodesoxicólico', '500 mg', 22.08, 'Comprimido revestido por película', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ursodesoxicólico', '250 mg', 11.04, 'Cápsula', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido ursodesoxicólico', '250 mg', 3.67, 'Cápsula', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '1000 mg', 60.85, 'Granulado de libertação prolongada', '100 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '500 mg', 36.14, 'Granulado de libertação prolongada', '100 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '300 mg', 23.48, 'Cápsula de libertação prolongada', '100 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '150 mg', 13.01, 'Cápsula de libertação prolongada', '100 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '300 mg', 6.64, 'Cápsula de libertação prolongada', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '1000 mg', 3.47, 'Granulado de libertação prolongada', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '1000 mg', 1.86, 'Granulado de libertação modificada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '500 mg', 1.76, 'Granulado de libertação prolongada', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '750 mg', 1.41, 'Granulado de libertação modificada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '500 mg', 1.11, 'Granulado de libertação modificada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '200 mg', 1.1, 'Comprimido revestido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '500 mg', 1.1, 'Comprimido gastrorresistente', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '500 mg', 1, 'Comprimido de libertação prolongada', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '300 mg', 0.65, 'Comprimido de libertação prolongada', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '150 mg', 0.55, 'Cápsula de libertação prolongada', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '40 mg/ml', 0.52, 'Xarope', '1 unidade(s) - 200 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '250 mg', 0.52, 'Granulado de libertação modificada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '200 mg', 0.48, 'Comprimido revestido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '200 mg/ml', 0.38, 'Solução oral', '1 unidade(s) - 50 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '100 mg', 0.29, 'Granulado de libertação modificada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido valpróico', '300 mg', 0.07, 'Comprimido de libertação prolongada', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Ácido zoledrónico', '5 mg/100 ml', 51.68, 'Solução para perfusão', '1 unidade(s) - 100 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acitretina', '25 mg', 33.81, 'Cápsula', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acitretina', '10 mg', 15.47, 'Cápsula', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Acitretina', '10 mg', 7.09, 'Cápsula', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adalimumab', '40 mg/0.8 ml', 954.33, 'Solução injetável', '2 unidade(s) - .8 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adalimumab', '80 mg/0.8 ml', 832.75, 'Solução injetável em caneta pré-cheia', '1 unidade(s) - .8 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adalimumab', '40 mg/0.4 ml', 797.46, 'Solução injetável em caneta pré-cheia', '2 unidade(s) - .4 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adalimumab', '20 mg/0.2 ml', 412.35, 'Solução injetável em seringa pré-cheia', '2 unidade(s) - .2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adapaleno', '1 mg/g', 14.77, 'Gel', '1 unidade(s) - 60 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adapaleno', '1 mg/g', 14.69, 'Creme', '1 unidade(s) - 60 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adapaleno + Peróxido de benzoílo', '3 mg/g + 25 mg/g', 36.89, 'Gel', '1 unidade(s) - 45 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adapaleno + Peróxido de benzoílo', '1 mg/g + 25 mg/g', 35.72, 'Gel', '1 unidade(s) - 60 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adapaleno + Peróxido de benzoílo', '3 mg/g + 25 mg/g', 26.58, 'Gel', '1 unidade(s) - 30 g');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.5 mg/0.5 ml', 84.14, 'Solução injetável em caneta pré-cheia', '2 unidade(s) - 5 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.15 mg/0.3 ml', 49.91, 'Solução injetável em seringa pré-cheia', '2 unidade(s) - 1.05 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.5 mg/0.5 ml', 45.12, 'Solução injetável em caneta pré-cheia', '1 unidade(s) - 5 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.3 mg/0.3 ml', 45.01, 'Solução injetável em seringa pré-cheia', '2 unidade(s) - 1.05 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.15 mg/0.3 ml', 31.3, 'Solução injetável em seringa pré-cheia', '1 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.3 mg/0.3 ml', 30.9, 'Solução injetável em seringa pré-cheia', '1 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.15 mg/0.3 ml', 28.97, 'Solução injetável em seringa pré-cheia', '1 unidade(s) - 1.05 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Adrenalina', '0.3 mg/0.3 ml', 28.58, 'Solução injetável em seringa pré-cheia', '1 unidade(s) - 1.05 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Agalsidase alfa', '1 mg/ml', 1700.98, 'Concentrado para solução para perfusão', '1 unidade(s) - 3.5 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Agomelatina', '25 mg', 19.01, 'Comprimido revestido por película', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Agomelatina', '25 mg', 11.06, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Albendazol', '20 mg/ml', 3.26, 'Suspensão oral', '1 unidade(s) - 20 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Albendazol', '400 mg', 2.8, 'Comprimido', '1 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alcatrão mineral', '40 mg/g', NULL, 'Champô', '1 unidade(s) - 150 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '24 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '36 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '6 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '16 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '40 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '8 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Amilmetacresol', '1.2 mg + 0.6 mg', NULL, 'Pastilha', '48 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Benzidamina', '0.24 mg/ml + 1.5 mg/ml', NULL, 'Solução bucal', '1 unidade(s) - 120 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Benzidamina', '6 mg/ml + 1.5 mg/ml', NULL, 'Solução para pulverização bucal', '1 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Benzidamina', '1.2 mg + 3 mg', NULL, 'Comprimido para chupar', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Benzidamina', '1.2 mg + 3 mg', NULL, 'Comprimido para chupar', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Benzidamina', '1.2 mg + 3 mg', NULL, 'Comprimido para chupar', '24 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool diclorobenzílico + Benzidamina', '1.2 mg + 3 mg', NULL, 'Comprimido para chupar', '16 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Álcool propílico + Etilsulfato de mecetrónio', '450 mg/g + 300 mg/g + 2 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 500 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Álcool propílico + Etilsulfato de mecetrónio', '450 mg/g + 300 mg/g + 2 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 200 l');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Álcool propílico + Etilsulfato de mecetrónio', '450 mg/g + 300 mg/g + 2 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 5000 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Álcool propílico + Etilsulfato de mecetrónio', '450 mg/g + 300 mg/g + 2 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 500 l');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Álcool propílico + Etilsulfato de mecetrónio', '450 mg/g + 300 mg/g + 2 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 25 l');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Álcool propílico + Etilsulfato de mecetrónio', '450 mg/g + 300 mg/g + 2 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 100 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Álcool propílico + Etilsulfato de mecetrónio', '450 mg/g + 300 mg/g + 2 mg/g', NULL, 'Solução cutânea', '1 unidade(s) - 1000 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Etanol', '83 mg/ml + 654.3 mg/ml', NULL, 'Solução cutânea', '1 unidade(s) - 5000 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Etanol', '83 mg/ml + 654.3 mg/ml', NULL, 'Solução cutânea', '20 unidade(s) - 500 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Etanol', '83 mg/ml + 654.3 mg/ml', NULL, 'Solução cutânea', '20 unidade(s) - 250 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Etanol', '83 mg/ml + 654.3 mg/ml', NULL, 'Solução cutânea', '20 unidade(s) - 100 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Álcool isopropílico + Etanol', '83 mg/ml + 654.3 mg/ml', NULL, 'Solução cutânea', '10 unidade(s) - 1000 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfacalcidol', '1 µg', 4.05, 'Cápsula', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfacalcidol', '0.5 µg', 3.07, 'Cápsula', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfacalcidol', '0.25 µg', 1.6, 'Cápsula', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfatocoferol', '150 mg', NULL, 'Cápsula', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfatocoferol', '150 mg', NULL, 'Cápsula', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '1 mg/2 ml', NULL, 'Solução injetável', '10 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '1 mg/2 ml', NULL, 'Solução injetável', '5 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '25 mg/50 ml', NULL, 'Solução injetável', '1 unidade(s) - 50 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '5 mg/10 ml', NULL, 'Solução injetável', '10 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '5 mg/10 ml', NULL, 'Solução injetável', '5 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '1 mg/2 ml', NULL, 'Solução injetável ou para perfusão', '5 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '1 mg/2 ml', NULL, 'Solução injetável ou para perfusão', '10 unidade(s) - 2 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '5 mg/10 ml', NULL, 'Solução injetável ou para perfusão', '5 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfentanilo', '5 mg/10 ml', NULL, 'Solução injetável ou para perfusão', '10 unidade(s) - 10 ml');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfuzosina', '5 mg', 12.41, 'Comprimido de libertação prolongada', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfuzosina', '10 mg', 4.86, 'Comprimido de libertação prolongada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfuzosina', '10 mg', 4.86, 'Comprimido de libertação modificada', '30 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfuzosina', '5 mg', 4.38, 'Comprimido de libertação prolongada', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfuzosina', '10 mg', 3.46, 'Comprimido de libertação modificada', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alfuzosina', '10 mg', 1.96, 'Comprimido de libertação prolongada', '10 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alginato de sódio + Bicarbonato de sódio + Carbonato de cálcio', 'Associação', NULL, 'Suspensão oral', '24 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alginato de sódio + Bicarbonato de sódio + Carbonato de cálcio', 'Associação', NULL, 'Suspensão oral', '12 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alginato de sódio + Bicarbonato de sódio + Carbonato de cálcio', '250 mg + 133.5 mg + 80 mg', NULL, 'Comprimido para mastigar', '24 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alginato de sódio + Bicarbonato de sódio + Carbonato de cálcio', '250 mg + 133.5 mg + 80 mg', NULL, 'Comprimido para mastigar', '16 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alginato de sódio + Bicarbonato de sódio + Carbonato de cálcio', '250 mg + 133.5 mg + 80 mg', NULL, 'Comprimido para mastigar', '8 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alginato de sódio + Bicarbonato de sódio + Carbonato de cálcio', '250 mg + 133.5 mg + 80 mg', NULL, 'Comprimido para mastigar', '48 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aliscireno', '300 mg', 8.04, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aliscireno', '150 mg', 6.13, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Aliscireno', '150 mg', 3.08, 'Comprimido revestido por película', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Almotriptano', '12.5 mg', 11.34, 'Comprimido revestido por película', '6 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Almotriptano', '12.5 mg', 6.23, 'Comprimido revestido por película', '3 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alogliptina', '6.25 mg', 9.97, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alogliptina', '25 mg', 3.8, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alogliptina', '25 mg', 2.05, 'Comprimido revestido por película', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alogliptina', '12.5 mg', 1.98, 'Comprimido revestido por película', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alogliptina', '12.5 mg', 1, 'Comprimido revestido por película', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alogliptina', '6.25 mg', 0.52, 'Comprimido revestido por película', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '100 mg', 3.03, 'Comprimido', '56 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '100 mg', 2.44, 'Comprimido', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '100 mg', 2.08, 'Comprimido', '25 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '300 mg', 1.94, 'Comprimido', '28 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '300 mg', 1.76, 'Comprimido', '15 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '300 mg', 1.7, 'Comprimido', '50 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '100 mg', 1.23, 'Comprimido', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '100 mg', 1, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '300 mg', 1, 'Comprimido', '14 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '300 mg', 0.99, 'Comprimido', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '300 mg', 0.98, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alopurinol', '100 mg', 0.29, 'Comprimido', '20 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alprazolam', '3 mg', 12.17, 'Comprimido de libertação modificada', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alprazolam', '2 mg', 9.97, 'Comprimido de libertação modificada', '60 unidade(s)');

INSERT INTO FARMACOS (PRINCIPIOATIVO, DOSAGEM, PRECO, FORMAFARMACO, UNIDADES) 
VALUES ('Alprazolam', '3 mg', 5.23, 'Comprimido de libertação modificada', '20 unidade(s)');

commit;

-- Eliminar informação as respetivas tabelas
delete from Triagem;
delete from Consulta_Especialidade;
delete from Consultas;
delete from Auxiliam;
delete from Urgencias;
delete from Usam;
delete from Da;
delete from Possuem;
delete from Passam;
delete from Receitas;
delete from Atendem;
delete from AtosMedicos;
delete from Utentes;
delete from Medicos;
delete from Enfermeiros;
delete from Empregados;
delete from Pessoas;
delete from Pulseiras;
delete from Especialidades;
delete from Materiais;


insert all
    into especialidades values ('Anatomia Patologica', 'A anatomia patológica e os seus médicos especialistas (anatomopagologistas) são responsáveis pela análise de material humano colhido no doente.')
    into especialidades values ('Anestesiologia', 'Quando um doente tem de fazer uma cirurgia e desde que esta não seja de urgência ou numa situação de emergência, deve fazer uma avaliação pré-operatória em consulta de anestesiologia.')
    into especialidades values ('Angiologia e Cirurgia Vascular', 'A Angiologia e Cirurgia Vascular é a especialidade que avalia os sinais e sintomas de doença das artérias, veias e vasos linfáticos, com o propósito de promover o seu tratamento médico e cirúrgico.')
    into especialidades values ('Cardiologia', 'A Cardiologia é a especialidade médica que se ocupa das doenças que atingem o coração e o sistema cardiovascular. As unidades CUF dispõem de uma equipa altamente especializada que se dedica desde a prevenção da doença cardiovascular ao seu diagnóstico e tratamento.')
    into especialidades values ('Cardiologia Pediatrica', 'A Cardiologia Pediátrica dedica a sua atenção ao diagnóstico e tratamento das doenças que atingem o coração e o sistema cardiovascular em idade pediátrica. As doenças cardiovasculares na criança, congénitas ou adquiridas, apresentam um perfil bastante diferente das predominantes no adulto e, como tal, impõe-se uma abordagem devidamente diferenciada, por especialistas nesta área.')
    into especialidades values ('Cirurgia Cardiaca', 'A Cirurgia Cardíaca é a especialidade que se dedica ao tratamento cirúrgico das doenças e deformidades do coração e dos vasos, nomeadamente das artérias coronárias, das válvulas cardíacas, da aorta e das anomalias cardíacas congénitas. Pela sua natureza, a cirurgia cardíaca está intimamente associada à especialidade de Cardiologia, funcionando em articulação com esta equipa.')
    into especialidades values ('Cirurgia Cardiotoracica', 'A Cirurgia Cardiotorácica é a especialidade cirúrgica focada no tratamento de doenças cardiovasculares e torácicas.')
    into especialidades values ('Cirurgia Geral', 'A Cirurgia Geral é a especialidade base de toda a Cirurgia, da qual derivaram as diversas especialidades cirúrgicas. Esta especialidade dedica-se ao tratamento cirúrgico de doenças de vários órgãos e sistemas, nomeadamente o aparelho digestivo, glândulas endócrinas e parede abdominal. Para tal utiliza técnicas de abordagem clássica ou minimamente invasivas (Laparoscopia). A Cirurgia Geral colabora no tratamento de patologias de outras especialidades médicas e cirúrgicas, integrando equipas multidisciplinares.')
    into especialidades values ('Cirurgia Maxilo-Facial', 'A Cirurgia Maxilo-Facial é a especialidade que trata as alterações que ocorrem nas estruturas da face, da cavidade oral e da região cervical, tendo sempre como objetivo a reabilitação das funções e a preservação da harmonia estética, em conjunto com a reconstrução.')
    into especialidades values ('Cirurgia Pediatrica', 'A Cirurgia Pediátrica é uma especialidade muito abrangente que se dedica ao tratamento cirúrgico de deformidades congénitas ou adquiridas, de lesões traumáticas ou de doenças adquiridas, atuando desde o nascimento da criança até aos 18 anos de idade.')
    into especialidades values ('Cirurgia Plastica Reco. e Est.', 'A cirurgia plástica, reconstrutiva e estética dedica-se ao tratamento cirúrgico de deformidades da pele, anexos e partes moles do corpo, e das estruturas nervosas e músculo-esqueléticas da face e da mão, nos seus aspetos estéticos, morfológicos e funcionais.')
    into especialidades values ('Cirurgia Toracica', 'A Cirurgia Torácica é a especialidade cirúrgica que se ocupa do tratamento e diagnóstico das doenças pulmonares e torácicas passíveis de abordagem cirúrgica, com exceção do coração e grandes vasos.')
    into especialidades values ('Dermatovenereologia', 'A Dermatovenereologia é a especialidade médico-cirúrgica que se centra no diagnóstico e tratamento das afeções da pele, cabelo, unhas, bem como de doenças das mucosas e infeções sexualmente transmissíveis.')
    into especialidades values ('Doencas Infecciosas', 'As Doenças Infecciosas, ou Infeciologia, é uma especialidade médica que se dedica à prevenção, diagnóstico e tratamento de infeções causadas por microorganismos, sejam eles bactérias, vírus, protozoários ou fungos. Nesta especialidade está ainda integrada a Consulta do Viajante, que tem como objetivo prestar aconselhamento sobre os riscos para a saúde inerentes às viagens, atuando ao nível da prevenção, mas também no diagnóstico e tratamento de doenças infecciosas, bem como de outras ocorrências que podem surgir no decurso dessas viagens.')
    into especialidades values ('Endocrinologia e Nutricao', 'A Endocrinologia é a especialidade médica que estuda o sistema endócrino, composto pelas glândulas de secreção interna ou endócrinas, responsável pela produção de múltiplas hormonas que, quando lançadas na circulação sanguínea, atuam na regulação do desenvolvimento e crescimento corporal e dos diferentes processos indispensáveis à manutenção da vida. Neste contexto, a Endocrinologia aborda diversas condições médicas, das quais se salientam, pela sua frequência, as doenças da tiroide, a diabetes e a obesidade.')
    into especialidades values ('Estomatologia', 'A estomatologia dedica-se à prevenção, diagnóstico e tratamento das doenças que afetam o sistema estomatognático.')
    into especialidades values ('Farmacologia Clinica', 'A Farmacologia Clínica é a especialidade médica que avalia os efeitos dos fármacos na espécie humana, saudável e doente, e na população em geral.')
    into especialidades values ('Gastrenterologia', 'A Gastrenterologia é a especialidade médica que se ocupa do estudo, diagnóstico, tratamento e prevenção das doenças do aparelho digestivo que incluem o esófago, estômago, intestino delgado, intestino grosso, fígado, vias biliares e pâncreas. ')
    into especialidades values ('Genetica Medica', 'A Genética Médica é a especialidade médica que oferece aconselhamento genético a pessoas em risco ou com doença monogénica. O especialista ajuda o doente a perceber desde a natureza da sua condição genética, à transmissão, e às opções existentes no âmbito da orientação médica e do planeamento familiar. Este aconselhamento, é muitas vezes proposto a pessoas saudáveis, em contexto de diagnóstico pré-sintomático ou do diagnóstico pré-natal ou pré-sintomático. As patologias envolvidas são aquelas com transmissão hereditária. É ainda a especialidade que se dedica ao diagnóstico etiológico do atraso do desenvolvimento psicomotor ou da perturbação do espetro do autismo, patologias identificáveis nos primeiros anos de vida.')
    into especialidades values ('Ginecologia/Obstreticia', 'A Ginecologia-Obstetrícia é uma especialidade médica e cirúrgica que engloba duas importantes áreas da saúde da mulher: a Ginecologia, centrada na prevenção, diagnóstico e tratamento das doenças benignas e malignas do aparelho reprodutor feminino. Entre os 13 e os 15 anos é a idade para ter a primeira consulta de Ginecologia.')
    into especialidades values ('Hematologia Clinica', 'A hematologia clínica dedica-se ao diagnóstico e tratamento das doenças do sangue e dos órgãos que intervêm na sua formação.')
    into especialidades values ('Imunoalergologia', 'A imunoalergologia dedica-se ao diagnóstico, tratamento e prevenção das doenças alérgicas e das doenças que comprometam o sistema imunitário.')
    into especialidades values ('Imuno-hemoterapia', 'A imunohemoterapia dedica-se à medicina transfusional e ao diagnóstico e tratamento das alterações da coagulação do sangue.')
    into especialidades values ('Medicina Desportiva', 'A medicina desportiva dedica-se ao diagnóstico e tratamento de doenças decorrentes da prática desportiva, bem como à proteção da saúde dos atletas.')
    into especialidades values ('Medicina do Trabalho', 'A medicina do trabalho dedica-se ao diagnóstico, prevenção e tratamento das alterações da saúde, das doenças e acidentes profissionais, assim como das questões ergonómicas, de higiene e segurança, fisiológicas e toxicológicas relacionadas com as condições e ambiente de trabalho.')
    into especialidades values ('Medicina Fisica e de Reabilitacao', 'A medicina física e de reabilitação dedica-se ao diagnóstico e tratamento de deficiências e incapacidades funcionais, de modo a reduzir o seu impacto.')
    into especialidades values ('Medicina Geral e Familiar', 'A medicina geral e familiar é a especialidade médica que se dedica ao seguimento a longo prazo da saúde de indivíduos de todos os escalões etários.')
    into especialidades values ('Medicina Intensiva', 'A medicina intensiva dedica-se ao diagnóstico e tratamento de situações de doença aguda potencialmente reversíveis em doentes que apresentem falência iminente ou estabelecida de uma ou mais funções vitais.')
    into especialidades values ('Medicina Interna', 'A medicina interna é uma especialidade generalista hospitalar que se dedica à prevenção, diagnóstico e orientação da terapêutica não cirúrgica das doenças dos vários órgãos e sistemas, em particular quando o doente tem afeção do que um órgão ou sistema. ')
    into especialidades values ('Medicina Legal', 'descricao')
    into especialidades values ('Medicina Nuclear', 'A medicina nuclear dedica-se ao diagnóstico e tratamento de doenças através da utilização de núcleos radioativos e permite uma avaliação da doença a nível molecular.')
    into especialidades values ('Medicina Tropical', 'descricao')
    into especialidades values ('Nefrologia', 'A nefrologia dedica-se ao diagnóstico e tratamento das doenças dos rins.')
    into especialidades values ('Neurocirurgia', 'A Neurocirurgia dedica-se ao diagnóstico e tratamento cirúrgico das doenças do sistema nervoso central e periférico e das doenças da coluna vertebral.')
    into especialidades values ('Neurologia', 'A neurologia dedica-se à prevenção, ao diagnóstico e tratamento das doenças do sistema nervoso.')
    into especialidades values ('Neurorradiologia', 'A neurorradiologia usa técnicas de imagem no diagnóstico, avaliação funcional e terapêutica de doenças do sistema nervoso central e periférico.')
    into especialidades values ('Oftalmologia', 'A oftalmologia dedica-se ao diagnóstico e tratamento das doenças dos olhos.')
    into especialidades values ('Oncologia Medica', 'A oncologia médica dedica-se ao diagnóstico e tratamento das doenças neoplásicas.')
    into especialidades values ('Ortopedia', 'A ortopedia dedica-se ao diagnóstico e tratamento médico e cirúrgico das doenças do sistema locomotor.')
    into especialidades values ('Otorrinolaringologia', 'A otorrinolaringologia é a especialidade médica que se dedica ao diagnóstico e tratamento médico e cirúrgico das doenças dos ouvidos, nariz, garganta, da cabeça e pescoço incluindo glândulas salivares e ainda da voz.')
    into especialidades values ('Patologia Clinica', 'A patologia clínica é a especialidade médica que se dedica ao diagnóstico laboratorial das doenças.')
    into especialidades values ('Pediatria', 'A pediatria dedica-se ao seguimento a longo prazo da saúde física, emocional e social das crianças e jovens.')
    into especialidades values ('Pneumologia', 'A pneumologia dedica-se à prevenção, diagnóstico e tratamento de doenças do sistema respiratório.')
    into especialidades values ('Psiquiatria', 'A psiquiatria dedica-se à prevenção, diagnóstico e tratamento de problemas mentais, emocionais ou comportamentais.')
    into especialidades values ('Psiquiatria da Infancia e da Adolescencia', 'A psiquiatria da infância e adolescência dedica-se à prevenção, diagnóstico e tratamento de problemas mentais, emocionais ou comportamentais nas crianças e jovens.')
    into especialidades values ('Radiologia', 'Radiologia é o ramo ou especialidade da medicina, da odontologia, da indústria, forense entre outras áreas que utiliza as radiações para a realização de diagnósticos, controle e tratamento de doenças.')
    into especialidades values ('Radioncologia', 'A Radioterapia é um tratamento aplicado em doenças oncológicas que utiliza radiações ionizantes de alta energia com o intuito de erradicar as células cancerígenas.')
    into especialidades values ('Reumatologia', 'A reumatologia dedica-se ao diagnóstico e tratamento das doenças músculo-esqueléticas.')
    into especialidades values ('Saude Publica', 'Saúde Pública é uma especialidade médica que se dedica à promoção, proteção e preservação da saúde coletiva de uma população. O seu foco principal está na prevenção de doenças, promoção de estilos de vida saudáveis e na melhoria das condições de saúde da comunidade em geral.')
    into especialidades values ('Urologia', 'A urologia dedica-se ao diagnóstico e tratamento médico e cirúrgico das doenças do aparelho urinário e do aparelho genital masculino.')
select * from dual;


insert all
    into pulseiras values ('Vermelha', 'Caso gravissimo. Risco de morte.')
    into pulseiras values ('Laranja', 'Caso grave com risco de vida.')
    into pulseiras values ('Amarela', 'Gravidade moderada sem risco imediato.')
    into pulseiras values ('Verde', 'Pode aguardar atendimento.')
    into pulseiras values ('Azul', 'Caso para atendimento na unidade se saude mais proxima da residencia ou aguardam atendimento de acordo com horario de chegada.')
    into pulseiras values ('Branca', 'Pacientes que aguardam admissao para internamento hospitalar.')
    into pulseiras values ('Preta', 'Pacientes com morte encefalica confirmada ou cujos sinais vitais nao estao presentes.')
select * from dual;



insert into materiais values (seq_num_produto.nextval, 'Seringa', 'Seringa injetável de vidro.', 'Medicina Geral', 100);
insert into materiais values (seq_num_produto.nextval, 'Máscara', 'Máscara cirurgica.', 'Medicina Geral', 200);
insert into materiais values (seq_num_produto.nextval, 'Luvas de latex', 'Luvas de latex.', 'Medicina Geral', 300);
insert into materiais values (seq_num_produto.nextval, 'Luvas de pvc', 'Luvas de pvc.', 'Medicina Geral', 400);
insert into materiais values (seq_num_produto.nextval, 'Viseiras', 'Viseiras cirurgicas.', 'Medicina Geral', 500);
insert into materiais values (seq_num_produto.nextval, 'Fita adesiva', 'Fita adesiva médica', 'Medicina Geral', 150);
insert into materiais values (seq_num_produto.nextval, 'Agulha descartável', 'Agulha descartável para injeção', 'Medicina Geral', 250);
insert into materiais values (seq_num_produto.nextval, 'Esparadrapo', 'Esparadrapo hipoalergênico', 'Medicina Geral', 300);
insert into materiais values (seq_num_produto.nextval, 'Atadura elástica', 'Atadura elástica para curativos', 'Medicina Geral', 200);
insert into materiais values (seq_num_produto.nextval, 'Gaze esterilizada', 'Gaze esterilizada para curativos', 'Medicina Geral', 400);
insert into materiais values (seq_num_produto.nextval, 'Termómetro', 'Termómetro digital', 'Medicina Geral', 50);
insert into materiais values (seq_num_produto.nextval, 'Curativo adesivo', 'Curativo adesivo esterilizado', 'Medicina Geral', 100);
insert into materiais values (seq_num_produto.nextval, 'Cateter intravenoso', 'Cateter intravenoso descartável', 'Medicina Geral', 150);
insert into materiais values (seq_num_produto.nextval, 'Garrote', 'Garrote de borracha', 'Medicina Geral', 80);
insert into materiais values (seq_num_produto.nextval, 'Algodão', 'Algodão hidrófilo', 'Medicina Geral', 200);
insert into materiais values (seq_num_produto.nextval, 'Tesoura cirúrgica', 'Tesoura cirúrgica esterilizada', 'Medicina Geral', 70);
insert into materiais values (seq_num_produto.nextval, 'Compressa estéril', 'Compressa estéril de gaze', 'Medicina Geral', 300);
insert into materiais values (seq_num_produto.nextval, 'Pinça hemostática', 'Pinça hemostática curva', 'Medicina Geral', 120);
insert into materiais values (seq_num_produto.nextval, 'Estetoscópio', 'Estetoscópio para ausculta', 'Medicina Geral', 90);
insert into materiais values (seq_num_produto.nextval, 'Sutura cirúrgica', 'Fio de sutura esterilizado', 'Medicina Geral', 180);
insert into materiais values (seq_num_produto.nextval, 'Gaze estéril', 'Gaze estéril dobrada', 'Medicina Geral', 400);
insert into materiais values (seq_num_produto.nextval, 'Fita adesiva microporosa', 'Fita adesiva microporosa', 'Medicina Geral', 150);
insert into materiais values (seq_num_produto.nextval, 'Atadura elástica', 'Atadura elástica coesa', 'Medicina Geral', 200);
insert into materiais values (seq_num_produto.nextval, 'Soro fisiológico', 'Solução de soro fisiológico', 'Medicina Geral', 500);
insert into materiais values (seq_num_produto.nextval, 'Cotonetes', 'Cotonetes de algodão', 'Medicina Geral', 350);
insert into materiais values (seq_num_produto.nextval, 'Máscara N95', 'Máscara N95 para proteção respiratória', 'Medicina Geral', 1000);
insert into materiais values (seq_num_produto.nextval, 'Bisturi descartável', 'Bisturi descartável estéril', 'Medicina Geral', 120);
insert into materiais values (seq_num_produto.nextval, 'Seringa de insulina', 'Seringa de insulina descartável', 'Medicina Geral', 180);
insert into materiais values (seq_num_produto.nextval, 'Termómetro Digital', 'Termómetro digital para medição de temperatura', 'Medicina Geral', 80);
insert into materiais values (seq_num_produto.nextval, 'Curativo adesivo', 'Curativo adesivo estéril', 'Medicina Geral', 300);




-- Inserir informação na tabela Pessoas, Médicos, Enfermeiros e Utentes

-- Inserir informação às tabela Médicos e Pessoas
insert into Pessoas values (158569054, 'Rodrigo Marques', 960123459, to_date('2002/05/21', 'YYYY/mm/DD'), 'Rua da Nascente');
insert into Pessoas values (654987008, 'David Pinto', 123456789, to_date('1999/07/22', 'YYYY/mm/DD'), 'Rua de Sintra');
insert into Pessoas values (321489009, 'Miguel Vieira', 123567890, to_date('1995/09/22', 'YYYY/mm/DD'), 'Rua de Lisboa');
insert into Pessoas values (316425023, 'Pinto Costa', 927815233, to_date('1980/01/20', 'YYYY/mm/DD'), 'Rua Alameda Afonso');
insert into Pessoas values (124516097, 'Carla Fernandes', 992145765, to_date('1976/03/05', 'YYYY/mm/DD'), 'Rua da Nova');
INSERT INTO Pessoas VALUES (987654321, 'João Santos', 912345678, TO_DATE('1995/03/18', 'YYYY/MM/DD'), 'Rua das Rosas');
INSERT INTO Pessoas VALUES (876543210, 'Maria Silva', 891234567, TO_DATE('1992/09/05', 'YYYY/MM/DD'), 'Rua dos Lírios');
INSERT INTO Pessoas VALUES (765432109, 'Pedro Oliveira', 678912345, TO_DATE('1987/07/11', 'YYYY/MM/DD'), 'Rua dos Girassóis');
INSERT INTO Pessoas VALUES (654321098, 'Ana Sousa', 123456789, TO_DATE('1990/04/22', 'YYYY/MM/DD'), 'Rua da Esperança');
INSERT INTO Pessoas VALUES (543210987, 'Miguel Rodrigues', 912345678, TO_DATE('1996/01/07', 'YYYY/MM/DD'), 'Rua das Papoilas');
INSERT INTO Pessoas VALUES (432109876, 'Inês Almeida', 234567891, TO_DATE('1993/06/28', 'YYYY/MM/DD'), 'Rua dos Crisântemos');
INSERT INTO Pessoas VALUES (321098765, 'Rui Pereira', 678912345, TO_DATE('1989/10/15', 'YYYY/MM/DD'), 'Rua dos Amores-Perfeitos');
insert into Medicos values (158569054, seq_num_id.nextval);
insert into Medicos values (654987008, seq_num_id.nextval);
insert into Medicos values (321489009, seq_num_id.nextval);
insert into Medicos values (316425023, seq_num_id.nextval);
insert into Medicos values (124516097, seq_num_id.nextval);
INSERT INTO Medicos VALUES (987654321, seq_num_id.nextval);
INSERT INTO Medicos VALUES (876543210, seq_num_id.nextval);
INSERT INTO Medicos VALUES (765432109, seq_num_id.nextval);
INSERT INTO Medicos VALUES (654321098, seq_num_id.nextval);
INSERT INTO Medicos VALUES (543210987, seq_num_id.nextval);
INSERT INTO Medicos VALUES (432109876, seq_num_id.nextval);
INSERT INTO Medicos VALUES (321098765, seq_num_id.nextval);

-- Inserir informação à tabela Enfermeiros e Pessoas
insert into Pessoas values (134652137, 'Fernanda Cruz', 975321742, to_date('1979/12/25', 'YYYY/mm/DD'), 'Rua de Almoinha');
insert into Pessoas values (134256159, 'Ana Clara', 924479392, to_date('1974/04/17', 'YYYY/mm/DD'), 'Rua dos Pelicanos');
insert into Pessoas values (451943375, 'Fernandes Silva', 212682134, to_date('1987/05/30', 'YYYY/mm/DD'), 'Rua Humberto Delgado');
INSERT INTO Pessoas VALUES (210987654, 'Sara Silva', 912345678, TO_DATE('1997/02/19', 'YYYY/MM/DD'), 'Rua das Margaridas');
INSERT INTO Pessoas VALUES (109876543, 'Daniel Ferreira', 345678912, TO_DATE('1994/08/03', 'YYYY/MM/DD'), 'Rua dos Cravos');
INSERT INTO Pessoas VALUES (321654987, 'Lara Oliveira', 789012345, TO_DATE('1991/11/26', 'YYYY/MM/DD'), 'Rua das Hortênsias');
INSERT INTO Pessoas VALUES (256481164, 'Tiago Martins', 234567891, TO_DATE('1998/06/12', 'YYYY/MM/DD'), 'Rua dos Jasmins');
INSERT INTO Pessoas VALUES (325102456, 'Carolina Costa', 678912345, TO_DATE('1995/09/23', 'YYYY/MM/DD'), 'Rua das Violetas');
INSERT INTO Pessoas VALUES (521025623, 'André Rodrigues', 123456789, TO_DATE('1992/12/04', 'YYYY/MM/DD'), 'Rua dos Lírios');
INSERT INTO Pessoas VALUES (965230022, 'Marta Santos', 912345678, TO_DATE('1988/03/15', 'YYYY/MM/DD'), 'Rua das Rosas');
INSERT INTO Pessoas VALUES (456201526, 'Diogo Almeida', 234567891, TO_DATE('1993/08/26', 'YYYY/MM/DD'), 'Rua dos Crisântemos');
INSERT INTO Pessoas VALUES (302015520, 'Rita Pereira', 678912345, TO_DATE('1997/05/07', 'YYYY/MM/DD'), 'Rua dos Girassóis');
INSERT INTO Pessoas VALUES (301256486, 'Carlos Silva', 912345678, TO_DATE('1994/10/18', 'YYYY/MM/DD'), 'Rua das Margaridas');
INSERT INTO Pessoas VALUES (502136402, 'Inês Ferreira', 345678912, TO_DATE('1991/01/29', 'YYYY/MM/DD'), 'Rua dos Cravos');
INSERT INTO Pessoas VALUES (325641258, 'José Oliveira', 789012345, TO_DATE('1987/04/10', 'YYYY/MM/DD'), 'Rua das Hortênsias');
insert into Enfermeiros values (134652137,seq_num_id.nextval);
insert into Enfermeiros values (134256159, seq_num_id.nextval);
insert into Enfermeiros values (451943375, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (210987654, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (109876543, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (321654987, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (256481164, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (325102456, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (521025623, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (965230022, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (302015520, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (301256486, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (502136402, seq_num_id.nextval);
INSERT INTO Enfermeiros VALUES (325641258, seq_num_id.nextval);

-- Inserir informação à tabela Utentes e Pessoas (quando necessário)
insert into Pessoas values (213264537, 'Sergio Paulo', 210893724, to_date('1973/12/12', 'YYYY/mm/DD'), 'Rua da AutoEuropa');
insert into Pessoas values (364213487, 'Fernandes Silva', 123567901, to_date('2001/01/31', 'YYYY/mm/DD'), 'Rua do Clube Naval');
insert into Pessoas values (115461834, 'Alvaro Guterres', 198654212, to_date('1987/10/11', 'YYYY/mm/DD'), 'Rua da Amadora');
insert into Pessoas values (125860129, 'Guilherme Cabral', 214356876, to_date('1994/03/03', 'YYYY/mm/DD'), 'Rua da Liberdade');
INSERT INTO Pessoas VALUES (102186411, 'Rita Santos', 987654321, TO_DATE('1990/08/15', 'YYYY/MM/DD'), 'Rua dos Lírios');
INSERT INTO Pessoas VALUES (221346512, 'Pedro Costa', 765432198, TO_DATE('1985/12/03', 'YYYY/MM/DD'), 'Rua das Oliveiras');
INSERT INTO Pessoas VALUES (423158333, 'Sofia Pereira', 567891234, TO_DATE('1992/04/27', 'YYYY/MM/DD'), 'Rua da Praia');
INSERT INTO Pessoas VALUES (413245164, 'Carlos Silva', 432198765, TO_DATE('1978/09/10', 'YYYY/MM/DD'), 'Rua dos Pinheiros');
INSERT INTO Pessoas VALUES (551382545, 'Mariana Rodrigues', 789123456, TO_DATE('1997/02/18', 'YYYY/MM/DD'), 'Rua das Flores');
INSERT INTO Pessoas VALUES (613344866, 'Tiago Almeida', 345678912, TO_DATE('1991/06/23', 'YYYY/MM/DD'), 'Rua do Sol');
INSERT INTO Pessoas VALUES (725642177, 'Inês Ferreira', 891234567, TO_DATE('1983/11/07', 'YYYY/MM/DD'), 'Rua dos Cravos');
INSERT INTO Pessoas VALUES (845618458, 'Hugo Gonçalves', 678912345, TO_DATE('1993/03/29', 'YYYY/MM/DD'), 'Rua da Esperança');
INSERT INTO Pessoas VALUES (932185699, 'Marta Oliveira', 123459876, TO_DATE('1996/07/14', 'YYYY/MM/DD'), 'Rua dos Jasmins');
INSERT INTO Pessoas VALUES (113125823, 'João Carvalho', 987612345, TO_DATE('1982/01/26', 'YYYY/MM/DD'), 'Rua dos Girassóis');
INSERT INTO Pessoas VALUES (231386464, 'Beatriz Sousa', 567123489, TO_DATE('1998/05/12', 'YYYY/MM/DD'), 'Rua das Margaridas');
INSERT INTO Pessoas VALUES (313645245, 'Leonardo Ferreira', 891234567, TO_DATE('1984/09/25', 'YYYY/MM/DD'), 'Rua dos Cedros');
INSERT INTO Pessoas VALUES (457895166, 'Lara Martins', 678912340, TO_DATE('1993/02/28', 'YYYY/MM/DD'), 'Rua das Violetas');
INSERT INTO Pessoas VALUES (566132797, 'André Santos', 123489675, TO_DATE('1989/06/02', 'YYYY/MM/DD'), 'Rua da Praça');
INSERT INTO Pessoas VALUES (673154648, 'Carolina Lima', 912345678, TO_DATE('1995/10/16', 'YYYY/MM/DD'), 'Rua das Azáleas');
INSERT INTO Pessoas VALUES (781326559, 'Gonçalo Castro', 234567891, TO_DATE('1987/03/07', 'YYYY/MM/DD'), 'Rua das Acácias');
INSERT INTO Pessoas VALUES (811263490, 'Inês Pereira', 678912345, TO_DATE('1990/07/21', 'YYYY/MM/DD'), 'Rua dos Jasmins');
INSERT INTO Pessoas VALUES (901326451, 'Ricardo Alves', 912345678, TO_DATE('1986/12/14', 'YYYY/MM/DD'), 'Rua dos Cravos');
INSERT INTO Pessoas VALUES (125436112, 'Mariana Silva', 345678912, TO_DATE('1994/04/08', 'YYYY/MM/DD'), 'Rua das Tulipas');
INSERT INTO Pessoas VALUES (115543185, 'Francisco Sousa', 789012345, TO_DATE('1988/08/30', 'YYYY/MM/DD'), 'Rua dos Narcisos');
INSERT INTO Pessoas VALUES (113465924, 'Rita Costa', 567891234, TO_DATE('1995/03/18', 'YYYY/MM/DD'), 'Rua das Rosas');
INSERT INTO Pessoas VALUES (313264518, 'Hugo Oliveira', 891234567, TO_DATE('1992/09/05', 'YYYY/MM/DD'), 'Rua dos Lírios');
INSERT INTO Pessoas VALUES (323164564, 'Sofia Rodrigues', 678912345, TO_DATE('1987/07/11', 'YYYY/MM/DD'), 'Rua dos Girassóis');
INSERT INTO Pessoas VALUES (121326465, 'Leonardo Santos', 123456789, TO_DATE('1990/04/22', 'YYYY/MM/DD'), 'Rua da Esperança');
INSERT INTO Pessoas VALUES (613264554, 'Carolina Almeida', 912345678, TO_DATE('1996/01/07', 'YYYY/MM/DD'), 'Rua das Papoilas');
INSERT INTO Pessoas VALUES (613261224, 'Gustavo Fernandes', 234567891, TO_DATE('1993/06/28', 'YYYY/MM/DD'), 'Rua dos Crisântemos');
INSERT INTO Pessoas VALUES (316401524, 'Mariana Pereira', 678912345, TO_DATE('1989/10/15', 'YYYY/MM/DD'), 'Rua dos Amores-Perfeitos');
INSERT INTO Pessoas VALUES (613263448, 'Ricardo Silva', 912345678, TO_DATE('1997/02/19', 'YYYY/MM/DD'), 'Rua das Margaridas');
INSERT INTO Pessoas VALUES (521323746, 'Lara Oliveira', 345678912, TO_DATE('1994/08/03', 'YYYY/MM/DD'), 'Rua dos Cravos');
INSERT INTO Pessoas VALUES (653789215, 'Gonçalo Ferreira', 789012345, TO_DATE('1991/11/26', 'YYYY/MM/DD'), 'Rua das Hortênsias');
insert into Utentes values (213264537, 223158831);
insert into Utentes values (364213487, 123651583);
insert into Utentes values (115461834, 358954157);
insert into Utentes values (125860129, 543215129);
insert into Utentes values (102186411, 325642001);
INSERT INTO Utentes VALUES (221346512, 461342754);
INSERT INTO Utentes VALUES (423158333, 653256452);
INSERT INTO Utentes VALUES (413245164, 987654321);
INSERT INTO Utentes VALUES (551382545, 654783216);
INSERT INTO Utentes VALUES (613344866, 963421154);
INSERT INTO Utentes VALUES (725642177, 346105612);
INSERT INTO Utentes VALUES (845618458, 256134679);
INSERT INTO Utentes VALUES (932185699, 124576831);
INSERT INTO Utentes VALUES (113125823, 643154976);
INSERT INTO Utentes VALUES (231386464, 312465972);
INSERT INTO Utentes VALUES (313645245, 316425642);
INSERT INTO Utentes VALUES (457895166, 165231654);
INSERT INTO Utentes VALUES (566132797, 321654896);
INSERT INTO Utentes VALUES (673154648, 753216546);
INSERT INTO Utentes VALUES (781326559, 654897321);
INSERT INTO Utentes VALUES (811263490, 154786321);
INSERT INTO Utentes VALUES (901326451, 254321546);
INSERT INTO Utentes VALUES (125436112, 453164579);
INSERT INTO Utentes VALUES (115543185, 461346514);
INSERT INTO Utentes VALUES (113465924, 231564879);
INSERT INTO Utentes VALUES (313264518, 216498752);
INSERT INTO Utentes VALUES (323164564, 541321464);
INSERT INTO Utentes VALUES (121326465, 321955646);
INSERT INTO Utentes VALUES (613264554, 987532165);
INSERT INTO Utentes VALUES (613261224, 987321654);
INSERT INTO Utentes VALUES (316401524, 153215463);
INSERT INTO Utentes VALUES (613263448, 654897225);
INSERT INTO Utentes VALUES (521323746, 654897329);
INSERT INTO Utentes VALUES (653789215, 231564873);
INSERT INTO Utentes VALUES (451943375, 263252468);
INSERT INTO Utentes VALUES (321654987, 302596314);
INSERT INTO Utentes VALUES (256481164, 523015469);
INSERT INTO Utentes VALUES (325102456, 985632140);
INSERT INTO Utentes VALUES (543210987, 658947236);
INSERT INTO Utentes VALUES (432109876, 745893152);
INSERT INTO Utentes VALUES (321098765, 154730210);


select *
from Pessoas;

select *
from Pessoas natural join Medicos;

select *
from Pessoas natural join Enfermeiros;

select *
from Pessoas natural join Utentes;


-- Base de dados pode ter o empregado como utente no hospital
select *
from Pessoas natural join Empregados natural join Utentes;


-- Associar a Especialidade ao Médico atraves da tabela Da
insert into Da values (158569054, 'Gastrenterologia');
insert into Da values (158569054, 'Dermatovenereologia');
insert into Da values (654987008, 'Nefrologia');
insert into Da values (654987008, 'Anestesiologia');
insert into Da values (321489009, 'Pediatria');
insert into Da values (321489009, 'Reumatologia');
insert into Da values (316425023, 'Oftalmologia');
insert into Da values (316425023, 'Ginecologia/Obstreticia');
insert into Da values (124516097, 'Urologia');
insert into Da values (124516097, 'Neurorradiologia');
INSERT INTO Da VALUES (987654321, 'Medicina Fisica e de Reabilitacao');
INSERT INTO Da VALUES (987654321, 'Medicina Geral e Familiar');
INSERT INTO Da VALUES (876543210, 'Cirurgia Geral');
INSERT INTO Da VALUES (876543210, 'Cirurgia Cardiaca');
INSERT INTO Da VALUES (876543210, 'Cirurgia Pediatrica');
INSERT INTO Da VALUES (765432109, 'Medicina do Trabalho');
INSERT INTO Da VALUES (765432109, 'Medicina Fisica e de Reabilitacao');
INSERT INTO Da VALUES (654321098, 'Oncologia Medica');
INSERT INTO Da VALUES (654321098, 'Radiologia');
INSERT INTO Da VALUES (543210987, 'Farmacologia Clinica');
INSERT INTO Da VALUES (543210987, 'Doencas Infecciosas');
INSERT INTO Da VALUES (543210987, 'Estomatologia');

select *
from Pessoas natural join Medicos Natural join Da;


-- criar processos de urgencia e relações de médicos e atos médicos
insert into Urgencias values (213264537, to_date('2023/05/20 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (213264537, 158569054, to_date('2023/05/20 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(134652137, 213264537, to_date('2023/05/20 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(213264537, to_date('2023/05/20 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/20 15:30', 'YYYY/mm/DD HH24:MI'), 'Amarela');
update Urgencias set datasaida = to_date('2023/05/20 18:00', 'YYYY/mm/DD HH24:MI') where NIF = 213264537 and dataentrada = to_date('2023/05/20 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (313264518, to_date('2023/05/20 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (313264518, 321098765, to_date('2023/05/20 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(134652137, 313264518, to_date('2023/05/20 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(313264518, to_date('2023/05/20 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/20 18:30', 'YYYY/mm/DD HH24:MI'), 'Amarela');
update Urgencias set datasaida = to_date('2023/05/20 20:00', 'YYYY/mm/DD HH24:MI') where NIF = 313264518 and dataentrada = to_date('2023/05/20 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (613264554, to_date('2023/05/21 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (613264554, 876543210, to_date('2023/05/21 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(134256159, 613264554, to_date('2023/05/21 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(613264554, to_date('2023/05/21 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/21 15:20', 'YYYY/mm/DD HH24:MI'), 'Laranja');
update Urgencias set datasaida = to_date('2023/05/22 20:00', 'YYYY/mm/DD HH24:MI') where NIF = 613264554 and dataentrada = to_date('2023/05/21 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (413245164, to_date('2023/05/21 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (413245164, 876543210, to_date('2023/05/21 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(134256159, 413245164, to_date('2023/05/21 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(413245164, to_date('2023/05/21 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/21 17:40', 'YYYY/mm/DD HH24:MI'), 'Amarela');
update Urgencias set datasaida = to_date('2023/05/21 19:00', 'YYYY/mm/DD HH24:MI') where NIF = 413245164 and dataentrada = to_date('2023/05/21 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (364213487, to_date('2023/05/22 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (364213487, 158569054, to_date('2023/05/22 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(451943375, 364213487, to_date('2023/05/22 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(364213487, to_date('2023/05/22 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/22 15:05', 'YYYY/mm/DD HH24:MI'), 'Vermelha');
update Urgencias set datasaida = to_date('2023/05/25 11:00', 'YYYY/mm/DD HH24:MI') where NIF = 364213487 and dataentrada = to_date('2023/05/22 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (256481164, to_date('2023/05/22 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (256481164, 321098765, to_date('2023/05/22 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(451943375, 256481164, to_date('2023/05/22 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(256481164, to_date('2023/05/22 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/22 17:45', 'YYYY/mm/DD HH24:MI'), 'Amarela');
update Urgencias set datasaida = to_date('2023/05/22 19:45', 'YYYY/mm/DD HH24:MI') where NIF = 256481164 and dataentrada = to_date('2023/05/22 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (121326465, to_date('2023/05/23 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (121326465, 654987008, to_date('2023/05/23 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(210987654, 121326465, to_date('2023/05/23 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(121326465, to_date('2023/05/23 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/23 17:00', 'YYYY/mm/DD HH24:MI'), 'Verde');
update Urgencias set datasaida = to_date('2023/05/23 17:45', 'YYYY/mm/DD HH24:MI') where NIF = 121326465 and dataentrada = to_date('2023/05/23 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (325102456, to_date('2023/05/23 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (325102456, 654987008, to_date('2023/05/23 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(210987654, 325102456, to_date('2023/05/23 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(325102456, to_date('2023/05/23 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/23 17:35', 'YYYY/mm/DD HH24:MI'), 'Amarela');
update Urgencias set datasaida = to_date('2023/05/23 23:15', 'YYYY/mm/DD HH24:MI') where NIF = 325102456 and dataentrada = to_date('2023/05/23 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (932185699, to_date('2023/05/24 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (932185699, 124516097, to_date('2023/05/24 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(109876543, 932185699, to_date('2023/05/24 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(932185699, to_date('2023/05/24 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/24 16:30', 'YYYY/mm/DD HH24:MI'), 'Azul');
update Urgencias set datasaida = to_date('2023/05/24 18:00', 'YYYY/mm/DD HH24:MI') where NIF = 932185699 and dataentrada = to_date('2023/05/24 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (213264537, to_date('2023/05/24 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (213264537, 124516097, to_date('2023/05/24 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(109876543, 213264537, to_date('2023/05/24 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(213264537, to_date('2023/05/24 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/24 17:50', 'YYYY/mm/DD HH24:MI'), 'Amarela');
update Urgencias set datasaida = to_date('2023/05/24 23:00', 'YYYY/mm/DD HH24:MI') where NIF = 213264537 and dataentrada = to_date('2023/05/24 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (566132797, to_date('2023/05/25 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (566132797, 321098765, to_date('2023/05/25 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(321654987, 566132797, to_date('2023/05/25 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(566132797, to_date('2023/05/25 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/25 15:40', 'YYYY/mm/DD HH24:MI'), 'Vermelha');
update Urgencias set datasaida = to_date('2023/05/29 12:15', 'YYYY/mm/DD HH24:MI') where NIF = 566132797 and dataentrada = to_date('2023/05/25 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (725642177, to_date('2023/05/25 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (725642177, 987654321, to_date('2023/05/25 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(321654987, 725642177, to_date('2023/05/25 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(725642177, to_date('2023/05/25 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/25 18:10', 'YYYY/mm/DD HH24:MI'), 'Laranja');
update Urgencias set datasaida = to_date('2023/05/26 15:40', 'YYYY/mm/DD HH24:MI') where NIF = 725642177 and dataentrada = to_date('2023/05/25 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (323164564, to_date('2023/05/26 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (323164564, 987654321, to_date('2023/05/26 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(321654987, 323164564, to_date('2023/05/26 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(323164564, to_date('2023/05/26 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/26 18:30', 'YYYY/mm/DD HH24:MI'), 'Verde');
update Urgencias set datasaida = to_date('2023/05/26 19:00', 'YYYY/mm/DD HH24:MI') where NIF = 323164564 and dataentrada = to_date('2023/05/26 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (551382545, to_date('2023/05/26 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (551382545, 654321098, to_date('2023/05/26 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(321654987, 551382545, to_date('2023/05/26 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(551382545, to_date('2023/05/26 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/26 18:30', 'YYYY/mm/DD HH24:MI'), 'Azul');
update Urgencias set datasaida = to_date('2023/05/26 20:00', 'YYYY/mm/DD HH24:MI') where NIF = 551382545 and dataentrada = to_date('2023/05/26 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (673154648, to_date('2023/05/27 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (673154648, 654321098, to_date('2023/05/27 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(134652137, 673154648, to_date('2023/05/27 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(673154648, to_date('2023/05/27 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/27 15:50', 'YYYY/mm/DD HH24:MI'), 'Laranja');
update Urgencias set datasaida = to_date('2023/05/27 21:30', 'YYYY/mm/DD HH24:MI') where NIF = 673154648 and dataentrada = to_date('2023/05/27 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (231386464, to_date('2023/05/27 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (231386464, 654987008, to_date('2023/05/27 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(134652137, 231386464, to_date('2023/05/27 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(231386464, to_date('2023/05/27 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/28 05:30', 'YYYY/mm/DD HH24:MI'), 'Verde');
update Urgencias set datasaida = to_date('2023/05/28 08:30', 'YYYY/mm/DD HH24:MI') where NIF = 231386464 and dataentrada = to_date('2023/05/27 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (653789215, to_date('2023/05/28 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (653789215, 321098765, to_date('2023/05/28 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(256481164, 653789215, to_date('2023/05/28 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(653789215, to_date('2023/05/28 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/28 15:30', 'YYYY/mm/DD HH24:MI'), 'Branca');
update Urgencias set datasaida = to_date('2023/05/28 16:00', 'YYYY/mm/DD HH24:MI') where NIF = 653789215 and dataentrada = to_date('2023/05/28 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (811263490, to_date('2023/05/28 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (811263490, 765432109, to_date('2023/05/28 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(256481164, 811263490, to_date('2023/05/28 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(811263490, to_date('2023/05/28 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/28 17:45', 'YYYY/mm/DD HH24:MI'), 'Vermelha');
update Urgencias set datasaida = to_date('2023/05/30 09:40', 'YYYY/mm/DD HH24:MI') where NIF = 811263490 and dataentrada = to_date('2023/05/28 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (316401524, to_date('2023/05/29 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (316401524, 654321098, to_date('2023/05/29 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(325102456, 316401524, to_date('2023/05/29 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(316401524, to_date('2023/05/29 15:00', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/29 17:30', 'YYYY/mm/DD HH24:MI'), 'Verde');
update Urgencias set datasaida = to_date('2023/05/29 18:00', 'YYYY/mm/DD HH24:MI') where NIF = 316401524 and dataentrada = to_date('2023/05/29 15:00', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (213264537, to_date('2023/05/29 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (213264537, 765432109, to_date('2023/05/29 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(325102456, 213264537, to_date('2023/05/29 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Triagem values(213264537, to_date('2023/05/29 17:30', 'YYYY/mm/DD HH24:MI'), to_date('2023/05/29 18:30', 'YYYY/mm/DD HH24:MI'), 'Azul');
update Urgencias set datasaida = to_date('2023/05/29 20:00', 'YYYY/mm/DD HH24:MI') where NIF = 213264537 and dataentrada = to_date('2023/05/29 17:30', 'YYYY/mm/DD HH24:MI');

insert into Urgencias values (423158333, to_date('2023/05/30 15:00', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (423158333, 876543210, to_date('2023/05/30 15:00', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(521025623, 423158333, to_date('2023/05/30 15:00', 'YYYY/mm/DD HH24:MI'));

insert into Urgencias values (457895166, to_date('2023/05/30 17:30', 'YYYY/mm/DD HH24:MI'), NULL);
insert into Atendem values (457895166, 876543210, to_date('2023/05/30 17:30', 'YYYY/mm/DD HH24:MI'));
insert into Auxiliam values(521025623, 457895166, to_date('2023/05/30 17:30', 'YYYY/mm/DD HH24:MI'));


-- criar processos de Consultas e relações de médicos e atos médicos
insert into Consultas values(653789215, to_date('2023/06/02 10:00', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (653789215, 158569054, to_date('2023/06/02 10:00', 'YYYY/mm/DD HH24:MI'));
insert into COnsulta_especialidade values(653789215, to_date('2023/06/02 10:00', 'YYYY/mm/DD HH24:MI'), 'Dermatovenereologia');

insert into Consultas values(451943375, to_date('2023/06/02 10:30', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (451943375, 654987008, to_date('2023/06/02 10:30', 'YYYY/mm/DD HH24:MI'));

insert into Consultas values(321654987, to_date('2023/06/03 10:00', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (321654987, 321489009, to_date('2023/06/03 10:00', 'YYYY/mm/DD HH24:MI'));
insert into COnsulta_especialidade values(321654987, to_date('2023/06/03 10:00', 'YYYY/mm/DD HH24:MI'), 'Reumatologia');

insert into Consultas values(256481164, to_date('2023/06/03 10:30', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (256481164, 158569054, to_date('2023/06/03 10:30', 'YYYY/mm/DD HH24:MI'));

insert into Consultas values(325102456, to_date('2023/06/04 10:00', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (325102456, 543210987, to_date('2023/06/04 10:00', 'YYYY/mm/DD HH24:MI'));
insert into COnsulta_especialidade values(325102456, to_date('2023/06/04 10:00', 'YYYY/mm/DD HH24:MI'), 'Farmacologia Clinica');

insert into Consultas values(543210987, to_date('2023/06/04 10:30', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (543210987, 158569054, to_date('2023/06/04 10:30', 'YYYY/mm/DD HH24:MI'));

insert into Consultas values(432109876, to_date('2023/06/10 10:00', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (432109876, 654321098, to_date('2023/06/10 10:00', 'YYYY/mm/DD HH24:MI'));
insert into COnsulta_especialidade values(432109876, to_date('2023/06/10 10:00', 'YYYY/mm/DD HH24:MI'), 'Radiologia');

insert into Consultas values(321098765, to_date('2023/06/10 10:30', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (321098765, 765432109, to_date('2023/06/10 10:30', 'YYYY/mm/DD HH24:MI'));

insert into Consultas values(125436112, to_date('2023/06/11 10:00', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (125436112, 876543210, to_date('2023/06/11 10:00', 'YYYY/mm/DD HH24:MI'));
insert into COnsulta_especialidade values(125436112, to_date('2023/06/11 10:00', 'YYYY/mm/DD HH24:MI'), 'Cirurgia Pediatrica');

insert into Consultas values(115543185, to_date('2023/06/11 10:30', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (115543185, 987654321, to_date('2023/06/11 10:30', 'YYYY/mm/DD HH24:MI'));

insert into Consultas values(113465924, to_date('2023/06/12 10:00', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (113465924, 124516097, to_date('2023/06/12 10:00', 'YYYY/mm/DD HH24:MI'));
insert into COnsulta_especialidade values(113465924, to_date('2023/06/12 10:00', 'YYYY/mm/DD HH24:MI'), 'Neurorradiologia');

insert into Consultas values(313264518, to_date('2023/06/12 10:30', 'YYYY/mm/DD HH24:MI'));
insert into Atendem values (313264518, 316425023, to_date('2023/06/12 10:30', 'YYYY/mm/DD HH24:MI'));


select *
from Pessoas natural join ATOSMEDICOS;


select *
from Atendem;


commit;

-- View que mostra os dados da pessoa que trabalha no hospital
create or replace view pessoa_emp as
    select * 
        from pessoas natural join empregados;

-- View que mostra os dados da presentes na entidade Passam relacionado 
-- com os atos medicos, receitas, possuem e os farmacos com o objetivo
-- poder adicionar o farmaco a receita
create or replace view receita_association as 
    select *
        from passam natural join atosmedicos
            natural join receitas natural join possuem
            natural join farmacos;

-- View que mostra os dados da pessoa que e utente no hospital
create or replace view dados_utentes as
    select *
        from utentes natural join pessoas;

-- View que mostra os dados da pessoa que trabalha no hospital como medico
create or replace view dados_medicos as
    select *
        from medicos natural join empregados natural join pessoas;

-- View que mostra os dados da pessoa que trabalha no hospital como enfermeiro
create or replace view dados_enfermeiros as
    select *
        from enfermeiros natural join empregados natural join pessoas;

-- View que mostra a idade da pessoa utilizando a data de nascimento
create or replace view idade as
    select nif,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM datadenascimento) AS idade
FROM pessoas;