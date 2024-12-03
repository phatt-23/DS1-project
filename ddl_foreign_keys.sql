
ALTER TABLE [channel] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [video] ADD FOREIGN KEY ([channel_id]) REFERENCES [channel] ([channel_id])
GO

ALTER TABLE [playlist] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [playlist_video] ADD FOREIGN KEY ([playlist_id]) REFERENCES [playlist] ([playlist_id])
GO

ALTER TABLE [playlist_video] ADD FOREIGN KEY ([video_id]) REFERENCES [video] ([video_id])
GO

ALTER TABLE [comment] ADD FOREIGN KEY ([comment_id]) REFERENCES [comment] ([parent_comment_id])
GO

ALTER TABLE [comment] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [comment] ADD FOREIGN KEY ([video_id]) REFERENCES [video] ([video_id])
GO

ALTER TABLE [reaction] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [subscription] ADD FOREIGN KEY ([subscriber_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [subscription] ADD FOREIGN KEY ([channel_id]) REFERENCES [channel] ([channel_id])
GO

ALTER TABLE [video_view] ADD FOREIGN KEY ([video_id]) REFERENCES [video] ([video_id])
GO

ALTER TABLE [video_view] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [video_category] ADD FOREIGN KEY ([video_id]) REFERENCES [video] ([video_id])
GO

ALTER TABLE [video_category] ADD FOREIGN KEY ([category_id]) REFERENCES [category] ([category_id])
GO

ALTER TABLE [category] ADD FOREIGN KEY ([category_id]) REFERENCES [category] ([parent_category_id])
GO

ALTER TABLE [video_advertisement] ADD FOREIGN KEY ([video_id]) REFERENCES [video] ([video_id])
GO

ALTER TABLE [video_advertisement] ADD FOREIGN KEY ([advertisement_id]) REFERENCES [advertisement] ([advertisement_id])
GO

ALTER TABLE [ad_impression] ADD FOREIGN KEY ([advertisement_id]) REFERENCES [advertisement] ([advertisement_id])
GO

ALTER TABLE [ad_impression] ADD FOREIGN KEY ([user_id]) REFERENCES [user] ([user_id])
GO

ALTER TABLE [ad_impression] ADD FOREIGN KEY ([video_id]) REFERENCES [video] ([video_id])
GO
