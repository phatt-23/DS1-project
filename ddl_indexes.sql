
CREATE INDEX [user_index_0] ON [user] ("username")
GO

CREATE INDEX [user_index_1] ON [user] ("email")
GO

CREATE INDEX [channel_index_2] ON [channel] ("user_id")
GO

CREATE INDEX [video_index_3] ON [video] ("channel_id")
GO

CREATE INDEX [video_index_4] ON [video] ("visibility")
GO

CREATE INDEX [video_index_5] ON [video] ("channel_id", "visibility")
GO

CREATE INDEX [playlist_index_6] ON [playlist] ("user_id")
GO

CREATE INDEX [playlist_index_7] ON [playlist] ("visibility")
GO

CREATE INDEX [playlist_index_8] ON [playlist] ("user_id", "visibility")
GO

CREATE INDEX [comment_index_9] ON [comment] ("video_id")
GO

CREATE INDEX [comment_index_10] ON [comment] ("user_id")
GO

CREATE INDEX [reaction_index_11] ON [reaction] ("target_type", "target_id")
GO

CREATE INDEX [subscription_index_12] ON [subscription] ("subscriber_id", "channel_id")
GO

CREATE INDEX [video_view_index_13] ON [video_view] ("video_id")
GO

CREATE INDEX [video_view_index_14] ON [video_view] ("user_id")
GO

CREATE INDEX [advertisement_index_15] ON [advertisement] ("target_audience")
GO

CREATE INDEX [advertisement_index_16] ON [advertisement] ("status")
GO

CREATE INDEX [advertisement_index_17] ON [advertisement] ("revenue")
GO

CREATE INDEX [video_advertisement_index_18] ON [video_advertisement] ("video_id", "advertisement_id")
GO

CREATE INDEX [ad_impression_index_19] ON [ad_impression] ("video_id")
GO
