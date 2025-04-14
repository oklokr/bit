package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.model.BoardDto;
import com.project.model.ReplyDto;
import com.project.repository.BoardMapper;

@Service
public class BoardService {
    @Autowired
    private BoardMapper boardmapper;

    public int getCount(){
        return boardmapper.getCount();
    }

    public List<BoardDto> getArticles(Map<String, Integer> map){
        return boardmapper.getArticles(map);
    }

    public BoardDto getArticle(int boardId){
        return boardmapper.getArticle(boardId);
    }

    public void addCount(int boardId){
        boardmapper.addCount(boardId);
    }

    public int insertPost(BoardDto boardDto){
        return boardmapper.insertPost(boardDto);
    }

    public int modifyPost(BoardDto boardDto){
        return boardmapper.modifyPost(boardDto);
    }

    public int deletePost(int boardId){
        return boardmapper.deletePost(boardId);
    }

    public int getReplyCount(int boardId){
        return boardmapper.getReplyCount(boardId);
    }

    public List<ReplyDto> getReplies(int boardId){
        return boardmapper.getReplies(boardId);
    }

    public int insertReply(ReplyDto replyDto){
        if (replyDto.getReplyLevel() == 0) {
            int maxRef = boardmapper.getMaxReplyRef();
            replyDto.setReplyRef(maxRef + 1);
            replyDto.setReplyStep(0);
        } else if (replyDto.getReplyLevel() == 1) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("boardId", replyDto.getBoardId());
            paramMap.put("replyRef", replyDto.getReplyRef());

            int maxStep = boardmapper.getMaxReplyStep(paramMap);
            replyDto.setReplyStep(maxStep + 1);
        }
       return boardmapper.insertReply(replyDto);
    }
    
    public int deleteReply(int replyId){
        ReplyDto replyDto = boardmapper.getReply(replyId);
        int replyRef = replyDto.getReplyRef();
        if(replyDto.getReplyLevel() == 0) {
            //원본 댓글 삭제 
            if (boardmapper.getNestedReplyCount(replyRef) != 0){
                //대댓글이 있는 경우
                Map<String, Object> map = new HashMap<>();
                map.put("replyId", replyId);
                map.put("replyTitle", "삭제된 댓글입니다");
                map.put("replyContent", "");
                return boardmapper.deleteRootReply(map);
            }
            else{
                return boardmapper.deleteReply(replyId);
            }
        } else {
            //대댓글 삭제
            //보드 아이디까지+replyId가 동일해야 함 
            Integer rootReplyState = boardmapper.getRootReplyState(replyRef);
            System.out.println("-------------rootreplystate------"+rootReplyState);
            if (rootReplyState != null && rootReplyState > 0){
                //원본 댓글이 지워진 경우
                System.out.println("원본 댓글이 지워진 경우");
                int rootReplyId = boardmapper.getRootReplyId(replyRef);
                System.out.println("rootReplyId: " + rootReplyId);
                if (boardmapper.getNestedReplyCount(replyRef) == 1){
                    System.out.println("대댓글이 없는 경우 replyRef의 댓 갯수 잘 구해옴?"+boardmapper.getNestedReplyCount(replyRef));
                    //다른 대댓글이 없는 경우 (이 댓글만 있는 경우) 원댓글 삭제
                    boardmapper.deleteReply(rootReplyId);
                }
            }
            return boardmapper.deleteReply(replyId);
        }
    }

}
