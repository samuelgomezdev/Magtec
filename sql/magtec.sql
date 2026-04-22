-- ============================================================
-- Banco de dados: Magtec Serviços Eletrônicos
-- HOW V - Univali
-- ============================================================

CREATE DATABASE IF NOT EXISTS magtec_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE magtec_db;

-- Tabela de administradores
CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    ultimo_acesso DATETIME,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de mensagens de contato
CREATE TABLE IF NOT EXISTS contatos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    equipamento VARCHAR(50),
    mensagem TEXT,
    status ENUM('novo', 'lido', 'respondido') DEFAULT 'novo',
    ip_origem VARCHAR(45),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de serviços exibidos no site
CREATE TABLE IF NOT EXISTS servicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_a_partir DECIMAL(10,2),
    icone VARCHAR(10),
    ativo TINYINT(1) DEFAULT 1,
    ordem INT DEFAULT 0,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Admin padrão (senha: magtec@2024) — ALTERE após o primeiro acesso
-- Hash gerado com password_hash('magtec@2024', PASSWORD_DEFAULT)
INSERT INTO admin (usuario, senha_hash, email)
VALUES ('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'magtec.serv@gmail.com')
ON DUPLICATE KEY UPDATE usuario = usuario;

-- Serviços iniciais
INSERT INTO servicos (nome, descricao, icone, ordem) VALUES
('Conserto de TV', 'Diagnóstico e reparo de TVs LED e LCD de todas as marcas, 32" a 65".', '📺', 1),
('Conserto de Microondas', 'Reparo de microondas de qualquer marca. Peças originais e compatíveis.', '🔧', 2),
('Controles Remotos', 'Venda e reparo de controles remotos universais e originais.', '📡', 3)
ON DUPLICATE KEY UPDATE nome = nome;
