package com.project.repository;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

import com.project.model.BoardDto;
import com.project.model.ReplyDto;

@Mapper
public interface BoardMapper {
    public int getCount();
    public List<BoardDto> getArticles(Map<String, Integer> map);
    public BoardDto getArticle(int boardId);
    public void addCount(int boardId);
    public int insertPost(BoardDto boardDto);
    public int modifyPost(BoardDto boardDto);
    public int deletePost(int boardId);
    public int getReplyCount(int boardId);
    public List<ReplyDto> getReplies(int boardId);
    public int insertReply(ReplyDto replyDto);
    public int getMaxReplyRef();
    public int getMaxReplyStep(Map<String, Object> paramMap);
    public int deleteReply(int replyId);
    public ReplyDto getReply(int replyId);
    public int getRootReplyState(int replyRef);
    public int getNestedReplyCount(int replyRef);
    public int deleteRootReply(Map<String, Object> map);
    public int getRootReplyId(int replyRef);
}