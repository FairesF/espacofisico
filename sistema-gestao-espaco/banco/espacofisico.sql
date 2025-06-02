CREATE TABLE Espacos_Fisicos (
    id_espaco SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    metragem DECIMAL(6,2) NOT NULL
);

CREATE TABLE Equipamentos (
    id_equipamento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Espaco_Equipamento (
    id_espaco INT REFERENCES Espacos_Fisicos(id_espaco),
    id_equipamento INT REFERENCES Equipamentos(id_equipamento),
    PRIMARY KEY (id_espaco, id_equipamento)
);

CREATE TABLE Solicitantes (
    id_solicitante SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Gestores (
    id_gestor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Solicitações (
    id_solicitacao SERIAL PRIMARY KEY,
    id_espaco INT REFERENCES Espacos_Fisicos(id_espaco),
    id_solicitante INT REFERENCES Solicitantes(id_solicitante),
    data_solicitacao DATE NOT NULL,
    data_reserva DATE NOT NULL,
    hora_reserva TIME NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('PENDENTE', 'APROVADA', 'REJEITADA')),
    UNIQUE(id_espaco, data_reserva, hora_reserva)
);

CREATE TABLE Avaliacoes (
    id_avaliacao SERIAL PRIMARY KEY,
    id_solicitacao INT UNIQUE REFERENCES Solicitações(id_solicitacao),
    id_gestor INT REFERENCES Gestores(id_gestor),
    status VARCHAR(20) NOT NULL CHECK (status IN ('APROVADA', 'REJEITADA')),
    justificativa TEXT,
    data_avaliacao DATE NOT NULL
);

CREATE TABLE Auditoria_Acoes (
    id_auditoria SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_usuario VARCHAR(20) CHECK (tipo_usuario IN ('SOLICITANTE', 'GESTOR')),
    acao TEXT NOT NULL,
    data_acao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


SELECT * FROM Espacos_Fisicos;
SELECT * FROM Solicitantes;
SELECT * FROM Gestores;
SELECT * FROM Solicitações;

SELECT s.id_solicitacao, s.data_reserva, s.hora_reserva, a.status, a.justificativa, g.nome AS gestor
FROM Avaliacoes a
JOIN Solicitações s ON s.id_solicitacao = a.id_solicitacao
JOIN Gestores g ON g.id_gestor = a.id_gestor;

SELECT s.id_solicitacao, e.nome AS espaco, s.data_reserva, s.hora_reserva
FROM Solicitações s
JOIN Espacos_Fisicos e ON e.id_espaco = s.id_espaco
WHERE s.status = 'APROVADA';




INSERT INTO Espacos_Fisicos (nome, tipo, metragem) VALUES
('Laboratório de Informática 1', 'Laboratório', 60.00),
('Estacionamento Bloco A', 'Vaga de Estacionamento', 120.00),
('Sala de Aula 101', 'Sala de Aula', 48.00),
('Sala de Reunião 1', 'Sala de Reunião', 30.00),
('Auditório Central', 'Auditório', 200.00),
('Sala de Videoconferência', 'Videoconferência', 25.00),
('Clínica Escola de Psicologia', 'Clínica Escola', 75.00),
('Pavilhão de Aula Bloco B', 'Pavilhão de Aula', 150.00),
('Centro de Esporte', 'Centro de Esporte', 300.00);
