# DBAssignment5_StoredProcedures

### Exercise 1

Write a stored procedure denormalizeComments(postID) that moves all comments for a post (the parameter) into a json array on the post.


```sql
CREATE DEFINER=`root`@`localhost` PROCEDURE `denormalizeComments`(IN postId INT)
BEGIN 
	IF NOT EXISTS(select 'comments' from posts) 
	THEN alter table posts add column comments json default null;
	END IF;

    update posts SET comments = (
    select JSON_ARRAYAGG(JSON_OBJECT(
    'ID',`Id`,
    'PostID', `PostId`,
    'Score', `Score`,
    'Text', `Text`,
    'CreationDate', `CreationDate`,
    'UserId', `UserId`
    ))
    from comments where PostID = postID 
    
    )
    WHERE Id = postID;
END
```

### Exercise 2

Create a trigger such that new adding new comments to a post triggers an insertion of that comment in the json array from exercise 1.

```sql
CREATE DEFINER=`root`@`localhost` TRIGGER `On_Comment_Insert` AFTER INSERT ON `comments` FOR EACH ROW 
CALL denormalizeComments(NEW.PostId);
```

### Exercise 3

Rather than using a trigger, create a stored procedure to add a comment to a post - adding it both to the comment table and the json array

```sql

CREATE DEFINER=`root`@`localhost` PROCEDURE `new_comment`(IN p_Id INT, IN p_PostId INT, IN p_Score INT, IN p_Text TEXT, IN p_CreationDate DATETIME, IN p_UserId INT)
BEGIN
	INSERT INTO comments(Id, PostId, Score, Text, CreationDate, UserId) VALUES (p_Id, p_PostId, p_Score, p_Text, p_CreationDate, p_UserId);
    UPDATE posts SET commentCount = commentCount+1 WHERE Id = p_Id;
    CALL denormalizeComments(p_PostId); 
END
```
