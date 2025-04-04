-- ✅ 공통 코드 데이터 삽입
INSERT IGNORE INTO common (common_code) VALUES 
('MEMBER_TYPE'),
('CATEGORY_TYPE'),
('TERMS_TYPE');

INSERT INTO common_codes (common_code, common_name, common_value, common_id) VALUES 
('MEMBER_TYPE', 'user', '1', 1),
('MEMBER_TYPE', 'admin', '2', 1),
('CATEGORY_TYPE', '인상재', '1', 2),
('CATEGORY_TYPE', '레진', '2', 2),
('CATEGORY_TYPE', '도포제', '3', 2),
('CATEGORY_TYPE', '왁스', '4', 2),
('CATEGORY_TYPE', '조각도 및 모터', '5', 2),
('CATEGORY_TYPE', '인상채득', '6', 2),
('CATEGORY_TYPE', '교합', '7', 2),
('CATEGORY_TYPE', '핀', '8', 2),
('CATEGORY_TYPE', '기타', '9', 2),
('TERMS_TYPE', 'service', '1', 3),
('TERMS_TYPE', 'privacy', '2', 3);

-- ✅ 회원 데이터 삽입
INSERT INTO members (id, company_name, password, email, phone_number, business_number, address, detailed_address, postal_code, member_type) VALUES 
('user', 'Company A', '1234', 'user@example.com', '010-1234-5678', '123-45-67890', '서울특별시 강남구', '101호', '12345', 1),
('admin', 'Company B', '1234', 'admin@example.com', '010-9876-5432', '987-65-43210', '부산광역시 해운대구', '202호', '54321', 2);

-- ✅ 약관 데이터 삽입
INSERT INTO terms (terms_title, terms_content, terms_type) VALUES 
('서비스 이용 약관', '서비스 이용 약관 내용입니다.', 5),
('개인정보 처리방침', '개인정보 처리방침 내용입니다.', 6);

-- ✅ 회원-약관 동의 데이터 삽입
INSERT INTO member_terms_agreement (member_no, terms_id) VALUES 
((SELECT member_no FROM members WHERE id = 'user'), 1),
((SELECT member_no FROM members WHERE id = 'user'), 2),
((SELECT member_no FROM members WHERE id = 'admin'), 1);

-- ✅ 상품 정보 데이터 삽입
INSERT INTO product_info (member_no, image, product_name, category_code, product_description) VALUES 
((SELECT member_no FROM members WHERE id = 'user'), 'image1.jpg', '노트북', 3, '최신형 노트북입니다.'),
((SELECT member_no FROM members WHERE id = 'user'), 'image2.jpg', '책상', 4, '튼튼한 책상입니다.');

-- ✅ 재고 데이터 삽입
INSERT INTO inventory (product_id, member_no, image, product_name, category_code, product_description, stock_quantity) VALUES 
(1, (SELECT member_no FROM members WHERE id = 'user'), 'image1.jpg', '노트북', 3, '최신형 노트북입니다.', 10),
(2, (SELECT member_no FROM members WHERE id = 'user'), 'image2.jpg', '책상', 4, '튼튼한 책상입니다.', 5);

-- ✅ 자유 게시판 데이터 삽입
INSERT INTO bulletin_board (member_no, title, author, view_count) VALUES 
((SELECT member_no FROM members WHERE id = 'user'), '첫 번째 게시글', 'user', 100),
((SELECT member_no FROM members WHERE id = 'user'), '두 번째 게시글', 'user', 50);

-- ✅ 답글 데이터 삽입
INSERT INTO replies (board_id, member_no, author, reply_title, reply_content, reply_order, reply_step, reply_level) VALUES 
(1, (SELECT member_no FROM members WHERE id = 'user'), 'user', '첫 번째 답글', '좋은 글 감사합니다.', 1, 0, 0),
(1, (SELECT member_no FROM members WHERE id = 'user'), 'user', '두 번째 답글', '감사합니다!', 2, 1, 1);