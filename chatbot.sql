CREATE DATABASE chatbot_db;
USE chatbot_db;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Conversations (
    conversation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    conversation_id INT,
    user_id INT,
    message_text TEXT NOT NULL,
    sent_by ENUM('user', 'chatbot') NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES Conversations(conversation_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE QueryPatterns (
    query_id INT AUTO_INCREMENT PRIMARY KEY,
    query_text VARCHAR(500) NOT NULL UNIQUE,
    occurrences INT DEFAULT 1,
    last_used TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ChatbotResponses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    query_id INT,
    response_text TEXT NOT NULL,
    response_accuracy DECIMAL(3,2) DEFAULT 0.0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (query_id) REFERENCES QueryPatterns(query_id) ON DELETE CASCADE
);

CREATE TABLE AIModels (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    version VARCHAR(20) NOT NULL,
    deployed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'deprecated') NOT NULL
);

-- Insert Users
INSERT INTO Users (username, email) VALUES 
('john_doe', 'john@example.com'),
('alice_smith', 'alice@example.com'),
('mike_jones', 'mike@example.com'),
('sara_connor', 'sara@example.com'),
('peter_parker', 'peter@example.com'),
('bruce_wayne', 'bruce@example.com'),
('clark_kent', 'clark@example.com'),
('diana_prince', 'diana@example.com'),
('tony_stark', 'tony@example.com'),
('steve_rogers', 'steve@example.com'),
('natasha_romanoff', 'natasha@example.com'),
('wanda_maximoff', 'wanda@example.com'),
('stephen_strange', 'stephen@example.com'),
('t_challa', 'tchalla@example.com'),
('scott_lang', 'scott@example.com');

-- Insert Conversations
INSERT INTO Conversations (user_id) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15);

-- Insert Messages
INSERT INTO Messages (conversation_id, user_id, message_text, sent_by) VALUES 
(1, 1, 'Hello, chatbot!', 'user'),
(1, NULL, 'Hello! How can I assist you?', 'chatbot'),
(2, 2, 'What is the time now?', 'user'),
(2, NULL, 'The current time is 10:00 AM.', 'chatbot'),
(3, 3, 'Tell me a joke.', 'user'),
(3, NULL, 'Why did the scarecrow win an award? Because he was outstanding in his field!', 'chatbot'),
(4, 4, 'How are you?', 'user'),
(4, NULL, 'I am just a chatbot, but thanks for asking!', 'chatbot'),
(5, 5, 'What is AI?', 'user'),
(5, NULL, 'AI stands for Artificial Intelligence, which enables machines to think like humans.', 'chatbot'),
(6, 6, 'Translate hello to French.', 'user'),
(6, NULL, 'Bonjour', 'chatbot'),
(7, 7, 'Tell me about space.', 'user'),
(7, NULL, 'Space is a vast expanse that exists beyond Earth’s atmosphere.', 'chatbot'),
(8, 8, 'Who invented the light bulb?', 'user'),
(8, NULL, 'The light bulb was invented by Thomas Edison.', 'chatbot');

-- Insert Query Patterns
INSERT INTO QueryPatterns (query_text, occurrences) VALUES 
('What is the weather today?', 1),
('Tell me a joke.', 3),
('Who is the president?', 2),
('How old is the Earth?', 1),
('Translate hello to Spanish.', 1),
('What is AI?', 2),
('Tell me about space.', 1),
('Who discovered gravity?', 1),
('Define machine learning.', 1),
('How does the internet work?', 1),
('What is 2 + 2?', 1),
('When was the first computer invented?', 1),
('Tell me about black holes.', 1),
('What is the speed of light?', 1),
('Who is the CEO of Tesla?', 1)
ON DUPLICATE KEY UPDATE occurrences = occurrences + 1, last_used = CURRENT_TIMESTAMP;

-- Insert Chatbot Responses
INSERT INTO ChatbotResponses (query_id, response_text, response_accuracy) VALUES 
(1, 'The weather today is sunny with a high of 25°C.', 0.95),
(2, 'Why don’t scientists trust atoms? Because they make up everything!', 0.90),
(3, 'The current president is [Insert Latest President].', 0.85),
(4, 'The Earth is approximately 4.5 billion years old.', 0.92),
(5, 'Hello in Spanish is "Hola".', 0.99),
(6, 'AI stands for Artificial Intelligence, which enables machines to simulate human intelligence.', 0.98),
(7, 'Space is a vast expanse that exists beyond Earth’s atmosphere.', 0.93),
(8, 'Gravity was discovered by Sir Isaac Newton.', 0.97),
(9, 'Machine learning is a subset of AI that enables computers to learn from data.', 0.94),
(10, 'The internet works through a network of interconnected devices communicating using protocols.', 0.96),
(11, '2 + 2 equals 4.', 1.00),
(12, 'The first computer was invented in the 1940s.', 0.88),
(13, 'A black hole is a region in space where gravity is so strong that nothing can escape.', 0.91),
(14, 'The speed of light is approximately 299,792 kilometers per second.', 0.99),
(15, 'The CEO of Tesla is Elon Musk.', 0.97);

-- Insert AI Models
INSERT INTO AIModels (model_name, version, status) VALUES 
('ChatGPT-4', 'v4.0.1', 'active'),
('ChatGPT-3.5', 'v3.5.2', 'deprecated'),
('GPT-3', 'v3.0.1', 'deprecated'),
('BERT', 'v2.0.0', 'deprecated'),
('T5', 'v1.1', 'deprecated'),
('XLNet', 'v1.0', 'deprecated'),
('GPT-2', 'v2.0', 'deprecated'),
('BART', 'v1.1', 'deprecated'),
('Electra', 'v1.0', 'deprecated'),
('DialoGPT', 'v1.0', 'deprecated'),
('GPT-Neo', 'v1.0', 'deprecated'),
('Llama', 'v1.0', 'deprecated'),
('Mistral', 'v1.0', 'deprecated'),
('Claude', 'v2.0', 'deprecated'),
('Gemini', 'v1.0', 'active');

-- Select Queries
SELECT * FROM Conversations WHERE user_id = 1;

SELECT * FROM Messages WHERE conversation_id = 1 ORDER BY timestamp;

SELECT query_text, occurrences FROM QueryPatterns ORDER BY occurrences DESC LIMIT 10;

SELECT * FROM AIModels WHERE status = 'active' ORDER BY deployed_at DESC LIMIT 1;

select * from Messages;