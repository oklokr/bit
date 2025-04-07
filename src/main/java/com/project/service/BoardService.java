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

    public BoardDto getArticle(int board_id){
        return boardmapper.getArticle(board_id);
    }

    public void addCount(int board_id){
        boardmapper.addCount(board_id);
    }

    public int insertPost(BoardDto boardDto){
        return boardmapper.insertPost(boardDto);
    }

    public int modifyPost(BoardDto boardDto){
        return boardmapper.modifyPost(boardDto);
    }

    public int deletePost(int board_id){
        return boardmapper.deletePost(board_id);
    }

    public int getReplyCount(int board_id){
        return boardmapper.getReplyCount(board_id);
    }

    public List<ReplyDto> getReplies(int board_id){
        return boardmapper.getReplies(board_id);
    }

    public int insertReply(ReplyDto replyDto){
        if (replyDto.getReply_level() == 0) {
            int maxRef = boardmapper.getMaxReplyRef(replyDto.getBoard_id());
            replyDto.setReply_ref(maxRef + 1);
            replyDto.setReply_step(0);
        } else if (replyDto.getReply_level() == 1) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("board_id", replyDto.getBoard_id());
            paramMap.put("reply_ref", replyDto.getReply_ref());

            int maxStep = boardmapper.getMaxReplyStep(paramMap);
            replyDto.setReply_step(maxStep + 1);
        }
       return boardmapper.insertReply(replyDto);
    }

}
