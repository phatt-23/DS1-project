
CREATE TABLE [user] (
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

CREATE TABLE [channel] (
  [channel_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [user_id] bigint,
  [channel_name] nvarchar(50) UNIQUE NOT NULL,
  [description] nvarchar(1000),
  [creation_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [video] (
  [video_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [channel_id] bigint,
  [thumbnail_url] nvarchar(1000) UNIQUE NOT NULL,
  [video_url] nvarchar(1000) UNIQUE NOT NULL,
  [visibility] nvarchar(255) NOT NULL CHECK ([visibility] IN ('private', 'public', 'hidden')) DEFAULT 'public',
  [is_monetized] bool DEFAULT (true),
  [title] nvarchar(255) NOT NULL,
  [description] nvarchar(1000),
  [upload_date] datetime NOT NULL DEFAULT (GETDATE()),
  [duration] integer NOT NULL,
  [view_count] integer NOT NULL
)
GO

CREATE TABLE [playlist] (
  [playlist_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [title] nvarchar(255) NOT NULL,
  [user_id] bigint,
  [visibility] nvarchar(255) NOT NULL CHECK ([visibility] IN ('private', 'public', 'hidden')) DEFAULT 'public',
  [creation_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [playlist_video] (
  [playlist_id] bigint,
  [video_id] bigint,
  [added_date] datetime NOT NULL DEFAULT (GETDATE()),
  PRIMARY KEY ([playlist_id], [video_id])
)
GO

CREATE TABLE [comment] (
  [comment_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [parent_comment_id] bigint,
  [user_id] bigint,
  [video_id] bigint,
  [content] nvarchar(500) NOT NULL,
  [comment_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [reaction] (
  [reaction_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [user_id] bigint,
  [target_type] nvarchar(255) NOT NULL CHECK ([target_type] IN ('video', 'comment', 'post')),
  [target_id] bigint NOT NULL,
  [reaction_type] nvarchar(255) NOT NULL CHECK ([reaction_type] IN ('like', 'dislike', 'love')),
  [reaction_date] datetime NOT NULL DEFAULT (GETDATE())
)
GO

CREATE TABLE [subscription] (
  [subscriber_id] bigint,
  [channel_id] bigint,
  [notification_preference] bool DEFAULT (true),
  [subscription_date] datetime NOT NULL DEFAULT (GETDATE()),
  PRIMARY KEY ([subscriber_id], [channel_id])
)
GO

CREATE TABLE [video_view] (
  [video_view_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [video_id] bigint,
  [user_id] bigint,
  [view_date] datetime NOT NULL DEFAULT (GETDATE()),
  [duration_watched] float NOT NULL
)
GO

CREATE TABLE [video_category] (
  [video_id] bigint,
  [category_id] bigint,
  PRIMARY KEY ([video_id], [category_id])
)
GO

CREATE TABLE [category] (
  [category_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [parent_category_id] bigint,
  [category_name] nvarchar(50) UNIQUE NOT NULL
)
GO

CREATE TABLE [advertisement] (
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

CREATE TABLE [video_advertisement] (
  [video_ad_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [video_id] bigint,
  [advertisement_id] bigint,
  [ad_type] nvarchar(255) NOT NULL CHECK ([ad_type] IN ('pre', 'mid', 'post', 'banner')) NOT NULL,
  [start_time] integer NOT NULL,
  [end_time] integer NOT NULL
)
GO

CREATE TABLE [ad_impression] (
  [ad_impression_id] bigint PRIMARY KEY IDENTITY(1, 1),
  [advertisement_id] bigint,
  [user_id] bigint,
  [video_id] bigint,
  [impression_date] datetime NOT NULL DEFAULT (GETDATE()),
  [clicked] bool NOT NULL DEFAULT (false),
  [device_type] nvarchar(255) NOT NULL CHECK ([device_type] IN ('mobile', 'desktop', 'tablet')),
  [impression_duration] integer
)
GO