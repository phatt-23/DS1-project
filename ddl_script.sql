CREATE TABLE [m_user] (
  [user_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [username] nvarchar(20) UNIQUE NOT NULL,
  [first_name] nvarchar(50) NOT NULL,
  [last_name] nvarchar(50) NOT NULL,
  [email] nvarchar(255) UNIQUE NOT NULL,
  [registration_date] datetime DEFAULT (GETDATE()),
  [about_me] nvarchar(500),
  [profile_picture_url] nvarchar(1000)
)
GO

CREATE TABLE [m_channel] (
  [channel_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [user_id] bigint,
  [channel_name] nvarchar(50) UNIQUE NOT NULL,
  [description] nvarchar(1000),
  [creation_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [m_video] (
  [video_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [channel_id] bigint,
  [thumbnail_url] nvarchar(1000) UNIQUE NOT NULL,
  [video_url] nvarchar(1000) UNIQUE NOT NULL,
  [visibility] nvarchar(255) NOT NULL CHECK ([visibility] IN ('private', 'public', 'hidden')) DEFAULT 'public',
  [is_monetized] bit DEFAULT (1),
  [title] nvarchar(255) NOT NULL,
  [description] nvarchar(1000),
  [upload_date] datetime NOT NULL DEFAULT (GETDATE()),
  [duration] integer NOT NULL,
  [view_count] integer NOT NULL
)
GO

CREATE TABLE [m_playlist] (
  [playlist_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [title] nvarchar(255) NOT NULL,
  [user_id] bigint,
  [visibility] nvarchar(255) NOT NULL CHECK ([visibility] IN ('private', 'public', 'hidden')) DEFAULT 'public',
  [creation_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [m_playlist_video] (
  [playlist_id] bigint,
  [video_id] bigint,
  [added_date] datetime NOT NULL DEFAULT (GETDATE()),
  PRIMARY KEY ([playlist_id], [video_id])
)
GO

CREATE TABLE [m_comment] (
  [comment_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [parent_comment_id] bigint,
  [user_id] bigint,
  [video_id] bigint,
  [content] nvarchar(500) NOT NULL,
  [comment_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [m_reaction] (
  [reaction_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [user_id] bigint NOT NULL,
  [target_type] nvarchar(255) NOT NULL CHECK ([target_type] IN ('video', 'comment', 'post')) NOT NULL,
  [target_id] bigint NOT NULL,
  [reaction_type] nvarchar(255) NOT NULL CHECK ([reaction_type] IN ('like', 'dislike', 'love')) NOT NULL,
  [reaction_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [m_subscription] (
  [subscriber_id] bigint,
  [channel_id] bigint,
  [notification_preference] bit DEFAULT (1),
  [subscription_date] datetime NOT NULL DEFAULT (GETDATE()),
  PRIMARY KEY ([subscriber_id], [channel_id])
)
GO

CREATE TABLE [m_video_view] (
  [video_view_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [video_id] bigint,
  [user_id] bigint,
  [view_date] datetime NOT NULL DEFAULT (GETDATE()),
  [duration_watched] float NOT NULL
)
GO

CREATE TABLE [m_video_category] (
  [video_id] bigint,
  [category_id] bigint,
  PRIMARY KEY ([video_id], [category_id])
)
GO

CREATE TABLE [m_category] (
  [category_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [parent_category_id] bigint,
  [category_name] nvarchar(50) UNIQUE NOT NULL
)
GO

CREATE TABLE [m_advertisement] (
  [advertisement_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [title] nvarchar(255) NOT NULL,
  [content] nvarchar(255) NOT NULL,
  [image_url] nvarchar(1000),
  [cta_link] nvarchar(1000),
  [target_audience] nvarchar(255) NOT NULL,
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('active', 'inactive', 'expired')) DEFAULT 'active',
  [click_rate] float NOT NULL,
  [revenue] MONEY NOT NULL,
  [budget] MONEY NOT NULL,
  [created_date] datetime NOT NULL DEFAULT (GETDATE()),
  [last_updated] datetime DEFAULT (GETDATE())
)
GO

CREATE TABLE [m_video_advertisement] (
  [video_ad_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [video_id] bigint,
  [advertisement_id] bigint,
  [ad_type] nvarchar(255) NOT NULL CHECK ([ad_type] IN ('pre', 'mid', 'post', 'banner')) NOT NULL,
  [start_time] integer NOT NULL,
  [end_time] integer NOT NULL
)
GO

CREATE TABLE [m_ad_impression] (
  [ad_impression_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [advertisement_id] bigint,
  [user_id] bigint,
  [video_id] bigint,
  [impression_date] datetime NOT NULL DEFAULT (GETDATE()),
  [clicked] bit NOT NULL DEFAULT (0),
  [device_type] nvarchar(255) NOT NULL CHECK ([device_type] IN ('mobile', 'desktop', 'tablet')),
  [impression_duration] integer
)
GO

CREATE INDEX [m_user_index_0] ON [m_user] ("username")
GO

CREATE INDEX [m_user_index_1] ON [m_user] ("email")
GO

CREATE INDEX [m_channel_index_2] ON [m_channel] ("user_id")
GO

CREATE INDEX [m_video_index_3] ON [m_video] ("channel_id")
GO

CREATE INDEX [m_video_index_4] ON [m_video] ("visibility")
GO

CREATE INDEX [m_video_index_5] ON [m_video] ("channel_id", "visibility")
GO

CREATE INDEX [m_playlist_index_6] ON [m_playlist] ("user_id")
GO

CREATE INDEX [m_playlist_index_7] ON [m_playlist] ("visibility")
GO

CREATE INDEX [m_playlist_index_8] ON [m_playlist] ("user_id", "visibility")
GO

CREATE INDEX [m_comment_index_9] ON [m_comment] ("video_id")
GO

CREATE INDEX [m_comment_index_10] ON [m_comment] ("user_id")
GO

CREATE INDEX [m_reaction_index_11] ON [m_reaction] ("target_type", "target_id")
GO

CREATE INDEX [m_subscription_index_12] ON [m_subscription] ("subscriber_id", "channel_id")
GO

CREATE INDEX [m_video_view_index_13] ON [m_video_view] ("video_id")
GO

CREATE INDEX [m_video_view_index_14] ON [m_video_view] ("user_id")
GO

CREATE INDEX [m_advertisement_index_15] ON [m_advertisement] ("target_audience")
GO

CREATE INDEX [m_advertisement_index_16] ON [m_advertisement] ("status")
GO

CREATE INDEX [m_advertisement_index_17] ON [m_advertisement] ("revenue")
GO

CREATE INDEX [m_video_advertisement_index_18] ON [m_video_advertisement] ("video_id", "advertisement_id")
GO

CREATE INDEX [m_ad_impression_index_19] ON [m_ad_impression] ("video_id")
GO

CREATE INDEX [m_ad_impression_index_20] ON [m_ad_impression] ("user_id")
GO

ALTER TABLE [m_channel] ADD FOREIGN KEY ([user_id]) REFERENCES [m_user] ([user_id])
GO

ALTER TABLE [m_video] ADD FOREIGN KEY ([channel_id]) REFERENCES [m_channel] ([channel_id])
GO

ALTER TABLE [m_playlist] ADD FOREIGN KEY ([user_id]) REFERENCES [m_user] ([user_id])
GO

ALTER TABLE [m_playlist_video] ADD FOREIGN KEY ([playlist_id]) REFERENCES [m_playlist] ([playlist_id])
GO

ALTER TABLE [m_playlist_video] ADD FOREIGN KEY ([video_id]) REFERENCES [m_video] ([video_id])
GO

ALTER TABLE [m_comment] ADD FOREIGN KEY ([comment_id]) REFERENCES [m_comment] ([parent_comment_id])
GO

ALTER TABLE [m_comment] ADD FOREIGN KEY ([user_id]) REFERENCES [m_user] ([user_id])
GO

ALTER TABLE [m_comment] ADD FOREIGN KEY ([video_id]) REFERENCES [m_video] ([video_id])
GO

ALTER TABLE [m_reaction] ADD FOREIGN KEY ([user_id]) REFERENCES [m_user] ([user_id])
GO

ALTER TABLE [m_subscription] ADD FOREIGN KEY ([subscriber_id]) REFERENCES [m_user] ([user_id])
GO

ALTER TABLE [m_subscription] ADD FOREIGN KEY ([channel_id]) REFERENCES [m_channel] ([channel_id])
GO

ALTER TABLE [m_video_view] ADD FOREIGN KEY ([video_id]) REFERENCES [m_video] ([video_id])
GO

ALTER TABLE [m_video_view] ADD FOREIGN KEY ([user_id]) REFERENCES [m_user] ([user_id])
GO

ALTER TABLE [m_video_category] ADD FOREIGN KEY ([video_id]) REFERENCES [m_video] ([video_id])
GO

ALTER TABLE [m_video_category] ADD FOREIGN KEY ([category_id]) REFERENCES [m_category] ([category_id])
GO

ALTER TABLE [m_category] ADD FOREIGN KEY ([category_id]) REFERENCES [m_category] ([parent_category_id])
GO

ALTER TABLE [m_video_advertisement] ADD FOREIGN KEY ([video_id]) REFERENCES [m_video] ([video_id])
GO

ALTER TABLE [m_video_advertisement] ADD FOREIGN KEY ([advertisement_id]) REFERENCES [m_advertisement] ([advertisement_id])
GO

ALTER TABLE [m_ad_impression] ADD FOREIGN KEY ([advertisement_id]) REFERENCES [m_advertisement] ([advertisement_id])
GO

ALTER TABLE [m_ad_impression] ADD FOREIGN KEY ([user_id]) REFERENCES [m_user] ([user_id])
GO

ALTER TABLE [m_ad_impression] ADD FOREIGN KEY ([video_id]) REFERENCES [m_video] ([video_id])
GO
