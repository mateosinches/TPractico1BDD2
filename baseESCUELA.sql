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
constraint foreign key(id_estudiante)REFERENCES estudiante(id)
);

;
ALTER TABLE `Calificacion`
add column calificacion int;

create table tipo_doc(
    id int primary key,
    cuil BIGINT,
    pasaporte int,
    dni int,
    cuit int
);
create table pais(
    id int primary key,
    pais varchar(30)
);

CREATE TABLE 
create table datos_personales(
id int primary key,
id_profesor INT
,id_estudiante INT
,id_pais INT
,id_tipodoc INT
,direccion varchar(56)
,fecha_nac DATETIME
,telefono INT
,apellido varchar(35)
,nombre VARCHAR(30)
,constraint foreign key (id_profesor)REFERENCES Profesor(id)
,constraint foreign key (id_estudiante)REFERENCES estudiante(id)
,constraint foreign key (id_pais)REFERENCES pais(id)
,constraint foreign key (id_tipodoc)REFERENCES tipo_doc(id)
);
ALTER TABLE datos_personales
ADD COLUMN edad INT;

UPDATE datos_personales
SET edad = DATEDIFF(CURDATE(), fecha_nac) DIV 30;
ALTER TABLE datos_personales
MODIFY COLUMN edad DECIMAL(4,1);
UPDATE datos_personales
SET edad = ROUND(DATEDIFF(CURDATE(), fecha_nac) / 365.25, 1);


INSERT INTO grado (id, nombre_grado) VALUES 
(1, 'Primero de primaria'),
(2, 'Segundo de Secundario'),
(3, 'Tercero de Preparatoria');

INSERT INTO nivel_educativo (id, id_grado, nivel) VALUES
(1, 1, 'Primaria'),
(2, 2, 'Secundario'),
(3, 3, 'Preparatoria');

INSERT INTO beca (id, fecha_sol, justificacion) VALUES
(1, '2022-01-01', 'Beca para estudiante con discapacidad motriz '),
(2, '2022-01-02', 'Beca para estudiante destacado en deportes');

INSERT INTO estudiante (id, id_beca, id_niveleducativo, direc_tutor, tutor, telefono_tutor) VALUES
(1, 1, 1, 'Calle Calera 123', 'Juan Pérez', 123456789),
(2, 2, 2, 'Calle cerrO 456', 'María Gómez', 987654321)
(3, 2, 1, 'Rafael Nunez 123', 'Pep Carlos', 1241321);


INSERT INTO Profesor (id, correo, asignaturas, horas, salario) VALUES
(1, 'jorgelin.profesor@gmail.com', 'Matemáticas, Física', 40, 2000.00),
(2, 'pancho.profesora@gmail.com', 'Lengua, Literatura', 35, 1800.00);

INSERT INTO Curso (id, id_profesor, id_estudiante, modalidad, forma_pago, horario) VALUES
(1, 1, 1, 'Presencial', 'Efectivo', 'Lunes a viernes de 8 a 10'),
(2, 2, 2, 'Virtual', 'Tarjeta de crédito', 'Sábados de 9 a 12');

INSERT INTO Asistencia (id, id_estudiante, id_curso, fecha_asistencia, presencia) VALUES
(1, 1, 1, '2022-02-01', 'Presente'),
(2, 2, 2, '2022-02-05', 'Ausente'),

(3, 1, 2, '2022-02-05', 'Ausente');


INSERT INTO Calificacion (id, id_estudiante,calificacion) VALUES
(1, 1,8),
(2, 2 ,5),
(3,3,10),
(4,2,7);


INSERT INTO tipo_doc (id, cuil, pasaporte, dni, cuit) VALUES
(1, 5984321 , NULL,  12345678, NULL),
(2, NULL, '12345678', NULL, NULL),
(3, NULL, Null, NULL, 204597293);


--  
INSERT INTO pais (id, pais) VALUES
(1, 'Argentina'),
(2, 'Francia');

INSERT INTO datos_personales (id, id_profesor, id_estudiante, id_pais, id_tipodoc, direccion, fecha_nac, telefono, apellido, nombre)
VALUES
(1, 1, NULL, 1, 2, 'Calle Calera 123', '1990-01-01', 5551234, 'Rosas', 'Juan'),
(2, 2, NULL, 1, 2, 'Calera 591', '2009-01-01', 49858012, 'Sinches', 'Julian');



#QUERY 1 EDAD_ALUUMNOS <14 ANIOS Y 6 MESES
select d.fecha_nac,d.id_estudiante,d.nombre,d.apellido,d.edad
from datos_personales d
where d.edad<14.6;

#QUERY 4 SALARIO
SELECT salario/horas AS monto_por_hora,id,asignaturas,horas
FROM `Profesor`;

#QUERY 2 CALIFICACION PROMEDIO
SELECT e.id AS id_estudiante,avg(c.calificacion) as PROMEDIO ,n.nivel
from estudiante as e
inner join nivel_educativo as n on e.id_niveleducativo = n.id
inner join Calificacion as c on c.id_estudiante = e.id
 group by id_estudiante

;

#ASISTENCIA QUERY 3
SELECT
  DATE_FORMAT(fecha_asistencia, '%Y-%m') AS mes,
  COUNT(*) AS total_clases,
  SUM(presencia = 'Presente') AS clases_presentes,
  SUM(presencia = 'Ausente') AS clases_ausentes,
  CONCAT(ROUND(SUM(presencia = 'Presente') * 100 / COUNT(*), 2), '%') AS porcentaje_asistencia,
  (SELECT fecha_asistencia FROM `Asistencia`  GROUP BY fecha_asistencia ORDER BY COUNT(*) DESC LIMIT 1) AS fecha_mas_inasistencias,
  (SELECT fecha_asistencia FROM `Asistencia`  GROUP BY fecha_asistencia ORDER BY COUNT(*) ASC LIMIT 1) AS fecha_mas_asistencias
FROM
  `Asistencia`
GROUP BY
  mes
;


#QUERY PRUEBA
SELECT e.id, e.direc_tutor, e.tutor, n.nivel, b.justificacion
FROM estudiante e
INNER JOIN nivel_educativo n ON e.id_niveleducativo = n.id
INNER JOIN beca b ON e.id_beca = b.id; 
