USE meossgdb;

DROP TABLE IF EXISTS OUTWAREHOUSE;
DROP TABLE IF EXISTS INWAREHOUSE;
DROP TABLE IF EXISTS PLACING_ORDER;
DROP TABLE IF EXISTS DELIVERY;
DROP TABLE IF EXISTS ORDER_LIST;
DROP TABLE IF EXISTS MEMBER_ORDER;
DROP TABLE IF EXISTS STOCK;
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS MEMBER;
DROP TABLE IF EXISTS ADMIN;

DROP TABLE IF EXISTS ADMIN;
CREATE TABLE IF NOT EXISTS ADMIN
(
    ID          VARCHAR(50) NOT NULL COMMENT '관리자번호',
    NAME        VARCHAR(50) NOT NULL COMMENT '이름',
    ASSOCIATION VARCHAR(50) NOT NULL COMMENT '소속',
    PASSWORD    VARCHAR(50) NOT NULL COMMENT '비밀번호',
    PRIMARY KEY ( ID )
) COMMENT = 'ADMIN';


DROP TABLE IF EXISTS MEMBER;
CREATE TABLE IF NOT EXISTS MEMBER
(
    ID       VARCHAR(50) NOT NULL COMMENT '회원번호',
    NAME     VARCHAR(50) NOT NULL COMMENT '이름',
    PHONE    VARCHAR(50) COMMENT '전화번호',
    ADDRESS  VARCHAR(50) NOT NULL COMMENT '주소',
    PASSWORD VARCHAR(50) NOT NULL COMMENT '비밀번호',
    PRIMARY KEY ( ID )
) COMMENT = 'MEMBER';


DROP TABLE IF EXISTS PRODUCT;
CREATE TABLE IF NOT EXISTS PRODUCT
(
    ID           INT         NOT NULL AUTO_INCREMENT COMMENT '상품번호',
    NAME         VARCHAR(50) NOT NULL COMMENT '이름',
    PRICE        INTEGER     NOT NULL COMMENT '가격',
    SIZE         VARCHAR(50) COMMENT '사이즈',
    COLOR        VARCHAR(50) COMMENT '색상',
    AVAILABILITY VARCHAR(10) NOT NULL COMMENT '판매여부',
    PRIMARY KEY ( ID )
) COMMENT = 'PRODUCT';


DROP TABLE IF EXISTS STOCK;
CREATE TABLE IF NOT EXISTS STOCK
(
    PRODUCT_ID INT NOT NULL COMMENT '상품번호',
    COUNT      INTEGER COMMENT '수량',
    PRIMARY KEY ( PRODUCT_ID ),
    FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT( ID )
) COMMENT = 'STOCK';


DROP TABLE IF EXISTS MEMBER_ORDER;
CREATE TABLE IF NOT EXISTS MEMBER_ORDER
(
    ID        INT         NOT NULL AUTO_INCREMENT COMMENT '주문번호',
    MEMBER_ID VARCHAR(50) NOT NULL COMMENT '회원번호',
    PRIMARY KEY ( ID ),
    FOREIGN KEY ( MEMBER_ID ) REFERENCES MEMBER( ID )
) COMMENT = 'ORDER';


DROP TABLE IF EXISTS ORDER_LIST;
CREATE TABLE IF NOT EXISTS ORDER_LIST
(
    ORDER_ID   INT     NOT NULL COMMENT '주문번호',
    PRODUCT_ID INT     NOT NULL COMMENT '상품번호',
    COUNT      INTEGER NOT NULL COMMENT '수량',
    PRIMARY KEY ( ORDER_ID, PRODUCT_ID ),
    FOREIGN KEY ( ORDER_ID ) REFERENCES MEMBER_ORDER( ID ),
    FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT( ID )
) COMMENT = 'ORDER_LIST';


DROP TABLE IF EXISTS DELIVERY;
CREATE TABLE IF NOT EXISTS DELIVERY
(
    ID              INT         NOT NULL AUTO_INCREMENT COMMENT '배송번호',
    ORDER_ID        INT         NOT NULL COMMENT '주문번호',
    STATUS          VARCHAR(50) NOT NULL COMMENT '배송상태',
    TRACKING_NUMBER VARCHAR(50) NOT NULL COMMENT '운송장번호',
    PACKAGING       VARCHAR(10) NOT NULL COMMENT '포장 사이즈',
    PRIMARY KEY ( ID ),
    FOREIGN KEY ( ORDER_ID ) REFERENCES MEMBER_ORDER( ID )
) COMMENT = 'DELIVERY';


DROP TABLE IF EXISTS PLACING_ORDER;
CREATE TABLE IF NOT EXISTS PLACING_ORDER
(
    ID            INT         NOT NULL AUTO_INCREMENT COMMENT '발주번호',
    PRODUCT_ID    INT         NOT NULL COMMENT '상품번호',
    ORDER_DATE    DATETIME    NOT NULL COMMENT '발주일',
    INWAREHOUSEYN VARCHAR(50) NOT NULL COMMENT '입고여부',
    PRIMARY KEY ( ID ),
    FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT( ID )
) COMMENT = 'PLACING_ORDER';


DROP TABLE IF EXISTS INWAREHOUSE;
CREATE TABLE IF NOT EXISTS INWAREHOUSE
(
    ID         INT      NOT NULL AUTO_INCREMENT COMMENT '입고번호',
    PRODUCT_ID INT      NOT NULL COMMENT '상품번호',
    IN_DATE    DATETIME NOT NULL COMMENT '입고일',
    PRIMARY KEY ( ID ),
    FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT( ID )
) COMMENT = 'INWAREHOUSE';


DROP TABLE IF EXISTS OUTWAREHOUSE;
CREATE TABLE IF NOT EXISTS OUTWAREHOUSE
(
    ID           INT         NOT NULL AUTO_INCREMENT COMMENT '출고번호',
    ORDER_NUMBER INT         NOT NULL COMMENT '주문번호',
    PRODUCT_ID   INT         NOT NULL COMMENT '상품번호',
    OUT_DATE     DATETIME    NOT NULL COMMENT '출고일',
    ADDRESS      VARCHAR(50) NOT NULL COMMENT '주소',
    PRIMARY KEY ( ID ),
    FOREIGN KEY ( ORDER_NUMBER ) REFERENCES MEMBER_ORDER( ID ),
    FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT( ID )
) COMMENT = 'OUTWAREHOUSE';



INSERT INTO member
VALUES ('changminbaby', '이창민', '01099004323', '서울 신림동 머쓱아파트 102동 1101호', 'honey');
INSERT INTO member
VALUES ('hyunkyunbaby', '석현균', '01011233344', '서울 강남구 강남대로 240', 'baby');
INSERT INTO member
VALUES ('kyunghobaby', '고경호', '01022223333', '경기도 용인시 상현동 자바아파트 103동 1204호', 'love');
INSERT INTO member
VALUES ('seunginbaby', '최승인', '01022334456', '경기도 용인시 엄청난 죽전동 오라클아파트 101동 1201호', 'darling');
INSERT INTO member
VALUES ('test', '테스트님', '01011112222', '서울시 강남구 강남역 8번출구', '1234');
INSERT INTO member
VALUES ('yoonjizzang', '장윤지', '01022955123', '경기도 용인시 엄청난 영덕동 타워팰리스 105동 1501호', 'yoonji');

INSERT INTO admin
VALUES ('OperTest', '테스트님', '쇼핑몰', '1234');
INSERT INTO admin
VALUES ('whadmin', '창고관리자1', '창고', '1q2w3e4r');

COMMIT;