package mocar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import dao.BoardDAO;

public class UpdateReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) {
		ActionForward forward = new ActionForward();
		BoardDAO bdao = new BoardDAO();
		
		int replynum = Integer.parseInt(req.getParameter("replynum"));
		String boardnum = req.getParameter("boardnum");
		String replycontents = req.getParameter("reply" + replynum);
		
		if(bdao.updateReply(replynum, replycontents)) {
			forward.setRedirect(true);
			forward.setPath(req.getContextPath() + "/mocar/BoardView.mc?boardnum=" + boardnum);
		}
		return forward;
	}

}
