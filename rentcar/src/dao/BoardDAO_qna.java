package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import mybatis.SqlMapConfig;


public class BoardDAO_qna {
	SqlSessionFactory factory = SqlMapConfig.getFactory();
	SqlSession sqlsession;
	
	public BoardDAO_qna() {
		// autocommit
		sqlsession = factory.openSession(true);
	}

	public List<BoardDTO_qna> getBoardList( int startRow, int endRow ) {
		HashMap<String, Integer> datas = new HashMap<>();
		datas.put("startRow", startRow);
		datas.put("endRow", endRow);
		List<BoardDTO_qna> boardList = sqlsession.selectList("Board_qna.getBoardList", datas);
		return boardList;
	}

	public int getBoardCnt() {
		return sqlsession.selectOne("Board_qna.getBoardCnt");
	}

	public boolean insertBoard(BoardDTO_qna board) {
		boolean result = false;
		
		if(sqlsession.insert("Board_qna.insertBoard", board) == 1) {
			result = true;
		}
		
		System.out.println("result : "+result);
		
		return result;
	}

	public BoardDTO_qna getDetail(int boardnum) {
		return (BoardDTO_qna)sqlsession.selectOne("Board_qna.getDetail", boardnum);
	}

	public void updateReadCount(int boardnum) {
		sqlsession.update("Board_qna.updateReadCount",boardnum);
	}

	public int getSeq() {
		return sqlsession.selectOne("Board_qna.getSeq");
	}


}


















