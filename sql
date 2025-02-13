-- ==================================================
-- 1) CRIAÇÃO DO BANCO DE DADOS
-- ==================================================
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- ==================================================
-- 2) CRIAÇÃO DAS TABELAS
-- ==================================================

-- Tabela Cliente
DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(200)
);

-- Tabela Veiculo
DROP TABLE IF EXISTS Veiculo;
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT,
    tipoVeiculo VARCHAR(50),
    statusVeiculo VARCHAR(50),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Mecanico
DROP TABLE IF EXISTS Mecanico;
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50) NOT NULL
);

-- Tabela OrdemServico
DROP TABLE IF EXISTS OrdemServico;
CREATE TABLE OrdemServico (
    idOrdem INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    idMecanico INT NOT NULL,
    tipoServico VARCHAR(50),
    dataEntrada DATE,
    dataEntrega DATE,
    tempoServico INT,
    status VARCHAR(50),
    observacoes TEXT,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Tabela Pagamento
DROP TABLE IF EXISTS Pagamento;
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idOrdem INT NOT NULL,
    valor DECIMAL(10,2),
    dataPagamento DATE,
    tipoPagamento VARCHAR(50),
    statusPagamento VARCHAR(50),
    FOREIGN KEY (idOrdem) REFERENCES OrdemServico(idOrdem)
);

-- ==================================================
-- 3) INSERÇÃO DE DADOS DE TESTE (INSERTs)
-- ==================================================

-- Clientes
INSERT INTO Cliente (nome, telefone, endereco) VALUES
('João Silva', '9999-9999', 'Rua A, 123'),
('Maria Oliveira', '8888-8888', 'Av. B, 456'),
('Pedro Santos', '7777-7777', 'Travessa C, 789');

-- Veiculos
INSERT INTO Veiculo (idCliente, marca, modelo, ano, tipoVeiculo, statusVeiculo) VALUES
(1, 'Ford', 'Fiesta', 2015, 'Carro', 'Em reparo'),
(2, 'Chevrolet', 'Onix', 2019, 'Carro', 'Em reparo'),
(3, 'Honda', 'CG 150', 2012, 'Moto', 'Concluído');

-- Mecanicos
INSERT INTO Mecanico (nome, especialidade) VALUES
('Carlos Andrade', 'Mecânica'),
('Fernando Sousa', 'Auto Elétrica'),
('João da Silva', 'Pintura');

-- Ordens de Serviço
INSERT INTO OrdemServico
(idVeiculo, idMecanico, tipoServico, dataEntrada, dataEntrega, tempoServico, status, observacoes)
VALUES
(1, 1, 'Troca de óleo', '2023-01-10', '2023-01-12', 2, 'Concluído', 'Incluído filtro de óleo'),
(2, 2, 'Reparo elétrico', '2023-01-15', NULL, 0, 'Em Andamento', 'Fusível queimado'),
(3, 3, 'Pintura lateral', '2023-01-20', '2023-01-25', 5, 'Concluído', 'Correção de arranhões na porta');

-- Pagamentos
INSERT INTO Pagamento
(idOrdem, valor, dataPagamento, tipoPagamento, statusPagamento)
VALUES
(1, 200.00, '2023-01-12', 'Crédito', 'Pago'),
(2, 350.00, NULL, 'Dinheiro', 'Pendente'),
(3, 500.00, '2023-01-25', 'Pix', 'Pago');

-- ==================================================
-- 4) EXEMPLOS DE QUERIES
-- ==================================================

-- 4.1) Recuperação simples (SELECT)
SELECT nome, telefone
FROM Cliente;

-- 4.2) Filtros (WHERE)
SELECT marca, modelo, statusVeiculo
FROM Veiculo
WHERE statusVeiculo = 'Em reparo';

-- 4.3) Expressões derivadas
SELECT 
    idPagamento,
    valor,
    (valor * 0.1) AS imposto,
    (valor + (valor * 0.1)) AS valor_total
FROM Pagamento;

-- 4.4) Ordenação (ORDER BY)
SELECT idMecanico, nome, especialidade
FROM Mecanico
ORDER BY nome DESC;

-- 4.5) Agrupamento e filtro em grupo (GROUP BY / HAVING)
SELECT statusVeiculo, COUNT(*) AS quantidade
FROM Veiculo
GROUP BY statusVeiculo
HAVING COUNT(*) > 1;

-- 4.6) Junções (JOIN)
SELECT 
    O.idOrdem,
    C.nome AS nomeCliente,
    M.nome AS nomeMecanico,
    V.marca,
    V.modelo,
    O.tipoServico,
    O.status AS statusOrdem
FROM OrdemServico O
JOIN Veiculo V ON O.idVeiculo = V.idVeiculo
JOIN Cliente C ON V.idCliente = C.idCliente
JOIN Mecanico M ON O.idMecanico = M.idMecanico;

-- FIM DO SCRIPT
