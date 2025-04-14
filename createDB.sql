SET FOREIGN_KEY_CHECKS = 0;

-- 🚨 기존 테이블 삭제 (순서 중요) 🚨
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS bulletin_board;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS product_info;
DROP TABLE IF EXISTS member_terms_agreement;
DROP TABLE IF EXISTS terms;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS common_codes;
DROP TABLE IF EXISTS common;

SET FOREIGN_KEY_CHECKS = 1;

-- ✅ 공통 코드 테이블 생성
CREATE TABLE common (
    common_id INT AUTO_INCREMENT PRIMARY KEY,
    common_code VARCHAR(50) UNIQUE NOT NULL,
    common_code_creation_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ✅ 공통 코드 상세 테이블 생성
CREATE TABLE common_codes (
    common_code_id INT AUTO_INCREMENT PRIMARY KEY,
    common_code VARCHAR(50) NOT NULL, -- common 테이블의 common_code를 참조
    common_name VARCHAR(100) NOT NULL,
    common_value VARCHAR(255) NOT NULL,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    common_id INT,
    FOREIGN KEY (common_code) REFERENCES common(common_code) ON DELETE CASCADE,
    FOREIGN KEY (common_id) REFERENCES common(common_id) ON DELETE CASCADE,
    KEY unique_common_code_value (common_code, common_value), -- 복합 인덱스 추가
    KEY idx_common_value (common_value) -- 단독 인덱스 추가
);

-- ✅ 회원 테이블 생성
CREATE TABLE members (
    member_no CHAR(36) PRIMARY KEY DEFAULT (UUID()),  
    id VARCHAR(50) UNIQUE NOT NULL,  
    company_name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    business_number VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    detailed_address VARCHAR(255),
    postal_code VARCHAR(20) NOT NULL,
    member_type VARCHAR(255) NULL,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    session_id VARCHAR(255),
    last_access_time DATETIME,
    session_expiry_time DATETIME,
    FOREIGN KEY (member_type) REFERENCES common_codes (common_value) ON DELETE SET NULL
);

-- ✅ 약관 테이블 생성
CREATE TABLE terms (
    terms_id INT AUTO_INCREMENT PRIMARY KEY,
    terms_title VARCHAR(255) NOT NULL,
    terms_content TEXT NOT NULL,
    terms_type VARCHAR(255) NULL,
    terms_required VARCHAR(1) NOT NULL,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (terms_type) REFERENCES common_codes (common_value) ON DELETE SET NULL
);

-- ✅ 회원-약관 동의 테이블 생성
CREATE TABLE member_terms_agreement (
    id VARCHAR(50),
    terms_id INT,
    agreement_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, terms_id),
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE CASCADE,
    FOREIGN KEY (terms_id) REFERENCES terms(terms_id) ON DELETE CASCADE
);

-- ✅ 상품 정보 테이블 생성
CREATE TABLE product_info (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(50),
    image VARCHAR(255),
    product_name VARCHAR(255) NOT NULL,
    category_code VARCHAR(255) NULL,
    product_description TEXT,
    product_registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE CASCADE,
    FOREIGN KEY (category_code) REFERENCES common_codes(common_value) ON DELETE SET NULL
);

-- ✅ 재고 관리 테이블 생성
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    id VARCHAR(50),
    image VARCHAR(255),
    product_name VARCHAR(255) NOT NULL,
    category_code VARCHAR(255) NULL,  
    product_description TEXT,
    stock_quantity INT NOT NULL DEFAULT 0,
    inventory_registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product_info(product_id) ON DELETE CASCADE,
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE CASCADE,
    FOREIGN KEY (category_code) REFERENCES common_codes(common_value) ON DELETE SET NULL,
    UNIQUE KEY unique_inventory (id, product_id)
);

-- ✅ 자유 게시판 테이블 생성
CREATE TABLE bulletin_board (
    board_id INT AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(50),
    title VARCHAR(255) NOT NULL,
    content VARCHAR(1000),
    author VARCHAR(100) NOT NULL,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    view_count INT DEFAULT 0,
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE SET NULL
);

-- ✅ 답글 테이블 생성
CREATE TABLE replies (
    reply_id INT AUTO_INCREMENT PRIMARY KEY,
    board_id INT NOT NULL,
    id VARCHAR(50),
    author VARCHAR(100) NOT NULL,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    reply_title VARCHAR(255),
    reply_content TEXT NOT NULL,
    reply_ref INT DEFAULT 0,
    reply_step INT DEFAULT 0,
    reply_level INT DEFAULT 0,
    FOREIGN KEY (board_id) REFERENCES bulletin_board(board_id) ON DELETE CASCADE,
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE SET NULL
);

-- ✅ 데이터 확인용 SELECT
SELECT * FROM common;
SELECT * FROM common_codes;
SELECT * FROM inventory;
SELECT * FROM members;
SELECT * FROM member_terms_agreement;
SELECT * FROM product_info;
SELECT * FROM terms;
SELECT * FROM bulletin_board;
SELECT * FROM replies;