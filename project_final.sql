CREATE TABLE mocar_join(
	userid 		varchar2(200) PRIMARY KEY,
	userpw 		varchar2(200),
	username 	varchar2(200),
	userBirth 	DATE		 ,
	usermail 	varchar2(200),
	usermember  varchar2(200)
);


SELECT * FROM mocar_join; 

INSERT INTO mocar_join VALUES ('test1', 'testpw123', '관리자', sysdate, 'nmjk0123@naver.com', '추천인1');

SELECT * FROM mocar_join WHERE userid = 'test1' AND USERPW = 'testpw123';

SELECT * FROM mocar_join WHERE username = '관리자' AND usermail = 'nmjk0123@naver.com';

UPDATE mocar_join SET userpw = 'testpw12' WHERE USERID = 'test12345';

DELETE from mocar_join WHERE USERID = 'apple';

--DROP TABLE mocar_join;

------------------------------------------------------------------------------------------

CREATE TABLE mc_coupon(
	couponnum 		varchar2(200) PRIMARY KEY,
	coupontitle 	varchar2(200),
	couponday 		varchar2(200)
);

INSERT INTO mc_coupon VALUES ('coupontest', '10% 할인쿠폰', '2022-12-16');

SELECT couponnum FROM mc_coupon WHERE couponnum = 'coupontest';
SELECT * FROM mc_coupon WHERE couponnum = 'coupontest';

SELECT * FROM mc_coupon; 

DROP TABLE mc_coupon;

------------------------------------------------------------------------------------------

--차량정보 테이블 생성
CREATE TABLE mocar_carinfo(
	carnum		number(10) PRIMARY KEY,
	cartype		number(10) NOT NULL,
	carname		VARCHAR2(200) NOT NULL,
	carname_sub	VARCHAR2(200),
	caryear		VARCHAR2(200),
	carprice	VARCHAR2(100) NOT NULL,
	carphoto	VARCHAR2(200)
);


SELECT * FROM MOCAR_CARINFO mc ;

SELECT * FROM MOCAR_CARINFO WHERE cartype = 4;

--carnum 시퀀스 생성
CREATE SEQUENCE carinfo_seq
START WITH 100
INCREMENT BY 1;

--자동차 컬럼 INSERT 
INSERT INTO MOCAR_CARINFO
VALUES (carinfo_seq.nextval, 2, 'Spark', 'Premier', '2022', '30,000', 'Spark.png');

INSERT INTO MOCAR_CARINFO
VALUES (carinfo_seq.nextval, 3, 'Malibu', 'Premier', '2021', '50,000', 'Malibu.png');

INSERT INTO MOCAR_CARINFO
VALUES (carinfo_seq.nextval, 3, 'Granduer', 'Leblanc', '2020', '60,000', 'Grandeur.jpg');

INSERT INTO MOCAR_CARINFO
VALUES (carinfo_seq.nextval, 4, 'Trailblaze', 'RS', '2021', '60,000', 'trailblazer.png');

INSERT INTO MOCAR_CARINFO
VALUES (carinfo_seq.nextval, 1, 'GV60', 'Standard', '2022', '70,000', 'gv60.png');

SELECT COUNT(*) FROM MOCAR_CARINFO;

--페이징처리
SELECT *
FROM (
	SELECT rownum R, C.*
	FROM (SELECT * FROM MOCAR_CARINFO ORDER BY carnum DESC) C
	) B
WHERE B.R BETWEEN 1 AND 10
; 

--예약정보 테이블 생성
CREATE TABLE MOCAR_CARRENT(
	rentUUID		varchar(1000) PRIMARY KEY,
	rentstartday	DATE,
	rentendday		DATE,
	carnum		number(10),
	CONSTRAINT	carnum_fk FOREIGN KEY(carnum) REFERENCES MOCAR_CARINFO(carnum)
);
--DROP TABLE MOCAR_CARRENT;

SELECT * FROM MOCAR_CARRENT ;


-- 날짜 중복 확인 쿼리
SELECT COUNT(CARNUM)  FROM MOCAR_CARRENT
WHERE rentstartday BETWEEN TO_DATE('2022-06-25', 'YYYY-MM-DD') 
                   AND TO_DATE('2022-06-25', 'YYYY-MM-DD') AND CARNUM = 105 ;

SELECT * FROM MOCAR_CARRENT ;


------------------------------------------------------------------------------------------


CREATE TABLE tbl_board(
   boardnum      	number(10) PRIMARY KEY ,
   boardtitle      	varchar2(300),
   boardcontent  	varchar2(4000),
   username      	varchar2(300),
   boarddate      	DATE,
   boardreadcount   number(10)   
);

SELECT * FROM  tbl_board ORDER BY BOARDNUM DESC;

CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1;

--DELETE FROM tbl_board;

DELETE FROM TBL_BOARD WHERE BOARDNUM = 35;

SELECT * FROM TBL_BOARD;

SELECT * FROM TBL_BOARD WHERE BOARDNUM = 1;

UPDATE TBL_BOARD SET BOARDREADCOUNT = BOARDREADCOUNT +1 WHERE BOARDNUM = 22;

SELECT board_seq.nextval FROM dual;
SELECT board_seq.CURRVAL FROM dual;

SELECT COUNT(*) FROM TBL_BOARD; 



INSERT INTO TBL_BOARD VALUES(BOARD_SEQ.NEXTVAL,'첫번째 글', '첫 번째 내용','자바학생',SYSDATE,0);
INSERT INTO TBL_BOARD VALUES(BOARD_SEQ.NEXTVAL,'두번째 글', '두 번째 내용','자바학생',SYSDATE,0);
INSERT INTO TBL_BOARD VALUES(BOARD_SEQ.NEXTVAL,'첫번째 글', '세 번째 내용','자바학생',SYSDATE,0);

/*업데이트문 추후 문제생기면 다시 수정해보기
UPDATE TBL_BOARD SET BOARDCONTENT = 'test001' WHERE BOARDNUM  = 1;*/


-- 삭제문
--DELETE FROM TBL_BOARD WHERE BOARDNUM = 54; 




--rownum
SELECT 	* 
FROM (SELECT  rownum R, D.* 
	FROM (SELECT * FROM TBL_BOARD ORDER BY BOARDNUM DESC) D)B
WHERE  B.R BETWEEN 1	AND 10	
;



---------------------------------------------------------
------------------------댓글------------------------------
---------------------------------------------------------
CREATE TABLE tbl_reply(
	replynum 		number(10) PRIMARY KEY ,
	replycontents 	varchar2(600),
	username		varchar2(300),
	password		varchar2(300),
	boardnum		number(10),
	CONSTRAINT rep_bd_fk2 FOREIGN KEY(boardnum) REFERENCES tbl_board(boardnum)
);

SELECT * FROM tbl_reply;

--DELETE FROM tbl_reply WHERE REPLYNUM = 8;

CREATE SEQUENCE reply_seq
START WITH 1
INCREMENT BY 1;


INSERT INTO TBL_REPLY VALUES (reply_seq.nextval, '댓글', '자바학생','1234', 46);

SELECT * FROM tbl_reply WHERE BOARDNUM = 22;

UPDATE TBL_REPLY SET REPLYCONTENTS = 'test1011' WHERE REPLYNUM = 1;

UPDATE TBL_BOARD SET BOARDCONTENT = '수정하기' WHERE BOARDNUM = 22;


--------------------------------------------------------------

CREATE TABLE qna_board(
   boardnum      	number(10) PRIMARY KEY ,
   boardtitle    	varchar2(300),
   boardcontent  	varchar2(4000),
   username      	varchar2(300),
   boarddate      	DATE,
   boardreadcount   number(10)   
);

SELECT * FROM  qna_board ORDER BY BOARDNUM DESC;

CREATE SEQUENCE qna_board_seq
START WITH 1
INCREMENT BY 1;

DROP TABLE qna_board;


--DELETE FROM qna_board WHERE BOARDNUM_qna = 35;

SELECT * FROM qna_board;

SELECT * FROM qna_board WHERE BOARDNUM = 1;

UPDATE qna_board SET BOARDREADCOUNT = BOARDREADCOUNT +1 WHERE BOARDNUM = 22;

SELECT qna_board_seq.nextval FROM dual;
SELECT qna_board_seq.CURRVAL FROM dual;

SELECT COUNT(*) FROM qna_board; 



INSERT INTO qna_board VALUES(BOARD_SEQ.NEXTVAL,'첫번째 글', '첫 번째 내용','자바학생',SYSDATE,0);
INSERT INTO qna_board VALUES(BOARD_SEQ.NEXTVAL,'두번째 글', '두 번째 내용','자바학생',SYSDATE,0);
INSERT INTO qna_board VALUES(BOARD_SEQ.NEXTVAL,'첫번째 글', '세 번째 내용','자바학생',SYSDATE,0);

/*업데이트문 추후 문제생기면 다시 수정해보기
UPDATE TBL_BOARD SET BOARDCONTENT = 'test001' WHERE BOARDNUM  = 1;*/


-- 삭제문
--DELETE FROM TBL_BOARD WHERE BOARDNUM = 54; 




--rownum
SELECT 	* 
FROM (SELECT  rownum R, D.* 
	FROM (SELECT * FROM qna_board ORDER BY BOARDNUM DESC) D)B
WHERE  B.R BETWEEN 1	AND 10	
;



---------------------------------------------------------
------------------------댓글------------------------------
---------------------------------------------------------
CREATE TABLE qna_reply(
	replynum 		number(10) PRIMARY KEY ,
	replycontents 	varchar2(600),
	username		varchar2(300),
	password		varchar2(300),
	boardnum		number(10),
	CONSTRAINT qna_rep_bd_fk2 FOREIGN KEY(boardnum) REFERENCES qna_board(boardnum)
);

--DROP TABLE qna_reply;

SELECT * FROM qna_reply;

--DELETE FROM tbl_reply WHERE REPLYNUM = 8;

CREATE SEQUENCE qna_reply_seq
START WITH 1
INCREMENT BY 1;


INSERT INTO qna_reply VALUES (qna_reply_seq.nextval, '댓글', '자바학생','1234', 46);

SELECT * FROM qna_reply WHERE BOARDNUM = 22;

UPDATE qna_reply SET REPLYCONTENTS = 'test1011' WHERE REPLYNUM_qna = 1;

UPDATE qna_board SET BOARDCONTENT = '수정하기' WHERE BOARDNUM_qna = 22;




