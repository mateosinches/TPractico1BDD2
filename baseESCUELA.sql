-- Active: 1677680548756@@127.0.0.1@3306@ESCUELA
-- Active: 1677680548756@@127.0.0.1@3306@ESCUELA
use ESCUELA;
CREATE TABLE grado (
    id INT NOT NULL,
    nombre_grado VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE nivel_educativo (
    id INT NOT NULL,
    id_grado INT NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_grado) REFERENCES grado(id)
);
CREATE TABLE beca (
    id INT NOT NULL,
    fecha_sol DATE NOT NULL,
    justificacion TEXT NOT NULL,
    PRIMARY KEY (id)
);
create table estudiante(
id int primary key,
id_beca INT,
id_niveleducativo INT,
direc_tutor varchar(120),
tutor varchar(50),
telefono_tutor BIGINT,
constraint foreign key(id_beca) REFERENCES beca(id),
constraint foreign key(id_niveleducativo)REFERENCES nivel_educativo(id)
);

CREATE TABLE Profesor (
    id INT PRIMARY KEY,
    correo VARCHAR(50),
    asignaturas VARCHAR(100),
    horas INT,
    salario DECIMAL(10,2)
);
CREATE TABLE Curso (
    id INT PRIMARY KEY,
    id_profesor INT,
    id_estudiante int,
    modalidad VARCHAR(50),
    forma_pago VARCHAR(50),
    horario VARCHAR(50),
    constraint FOREIGN KEY (id_profesor) REFERENCES Profesor(id),
    constraint foreign key(id_estudiante)REFERENCES estudiante(id)
);
create table Asistencia(
    id int primary key,
    id_estudiante int,
    id_curso int,
    fecha_asistencia DATE,
    presencia varchar(30),
    constraint foreign key(id_estudiante)REFERENCES estudiante(id),
    constraint foreign key(id_curso)REFERENCES Curso(id)
);
create table Calificacion(
id int primary key,
id_estudiante int,
    id_curso int,
constraint foreign key(id_estudiante)REFERENCES estudiante(id),
    constraint foreign key(id_curso)REFERENCES Curso(id)
);
create table tipo_doc(
    id int primary key,
    cuil INT,
    pasaporte int,
    dni int,
    cuit int
);
create table pais(
    id int primary key,
    pais varchar(30)
);
create table datos_personales(
id int primary key,
id_profesor INT
,id_estudiante INT
,id_pais INT
,id_tipodoc INT
,direccion varchar(56)
,fecha_nac DATE
,telefono INT
,apellido varchar(35)
,nombre VARCHAR(30)
,constraint foreign key (id_profesor)REFERENCES Profesor(id)
,constraint foreign key (id_estudiante)REFERENCES estudiante(id)
,constraint foreign key (id_pais)REFERENCES pais(id)
,constraint foreign key (id_tipodoc)REFERENCES tipo_doc(id)
);
