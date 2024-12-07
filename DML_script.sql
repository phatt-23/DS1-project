-- Insert statements for y_user
INSERT INTO y_user 
    (username, first_name, last_name, email, about_me, profile_picture_url)
VALUES
    (
        'johndoe',
        'John',
        'Doe',
        'johndoe@example.com',
        'Hello, I am John!',
        'https://example.com/profile/johndoe.jpg'
    ),
    (
        'janedoe',
        'Jane',
        'Doe',
        'janedoe@example.com',
        'Welcome to my profile!',
        'https://example.com/profile/janedoe.jpg'
    )
;


-- Insert statements for y_channel
INSERT INTO y_channel 
    (user_id, channel_name, description)
VALUES
    (
        (SELECT user_id FROM y_user WHERE username = 'johndoe'),
        'JohnsChannel',
        'A channel about technology and programming.'
    ),
    (
        (SELECT user_id FROM y_user WHERE username = 'janedoe'),
        'JanesChannel',
        'Sharing my passion for arts and crafts.'
    )
;


-- Insert statements for y_video
INSERT INTO y_video 
    (channel_id, thumbnail_url, video_url, title, description, duration, view_count)
VALUES
    (
        (SELECT channel_id
           FROM y_channel
          WHERE y_channel.channel_name = 'JohnsChannel'
            AND y_channel.user_id = (SELECT user_id FROM y_user WHERE username = 'johndoe')),
        'https://example.com/thumbnail6.jpg',
        'https://example.com/video5.mp4',
        'Intro to Programming',
        'Learn programming basics.',
        600,
        1000
    ),
    (
        (SELECT channel_id
           FROM y_channel
          WHERE y_channel.channel_name = 'JanesChannel'
            AND y_channel.user_id = (SELECT user_id FROM y_user WHERE username = 'janedoe')),
        'https://example.com/thumbnail8.jpg',
        'https://example.com/video6.mp4',
        'Art Tutorial',
        'Beginner art techniques.',
        1200,
        500
    )
;


-- Insert statements for y_playlist
INSERT INTO y_playlist 
    (title, user_id, visibility)
VALUES
    (
        'Programming Tutorials',
        (SELECT user_id FROM y_user WHERE y_user.username = 'johndoe'),
        'public'
    ),
    (
        'Art Inspirations',
        (SELECT user_id FROM y_user WHERE y_user.username = 'janedoe'),
        'private'
    )
;


-- Insert statements for y_playlist_video
INSERT INTO y_playlist_video 
    (playlist_id, video_id, [order])
VALUES
    (
        (SELECT playlist_id FROM y_playlist WHERE y_playlist.playlist_id = 1),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 2),
        1
    ),
    (
        (SELECT playlist_id FROM y_playlist WHERE y_playlist.playlist_id = 2),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        1
    )
;


-- Insert statements for y_comment
INSERT INTO y_comment 
    (parent_comment_id, user_id, video_id, content)
VALUES
    (
        NULL,
        (SELECT user_id FROM y_user WHERE y_user.username = 'johndoe'),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        'Great video! Thanks for sharing.'
    ),
    (
        (SELECT comment_id FROM y_comment WHERE comment_id = 1 AND video_id = 1),
        (SELECT user_id FROM y_user WHERE y_user.username = 'janedoe'),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        'You’re welcome!'
    )
;


-- Insert statements for y_reaction
INSERT INTO y_reaction 
    (user_id, video_id, comment_id, reaction_type)
VALUES
    (
        (SELECT user_id FROM y_user WHERE y_user.username = 'johndoe'),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        (SELECT comment_id FROM y_comment WHERE comment_id = 1 AND video_id = 1),
        'like'
    ),
    (
        (SELECT user_id FROM y_user WHERE y_user.username = 'janedoe'),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        (SELECT comment_id FROM y_comment WHERE comment_id = 1 AND video_id = 1),
        'love'
    )
;


-- Insert statements for y_subscription
INSERT INTO y_subscription 
    (subscriber_id, channel_id)
VALUES
    (
        (SELECT user_id FROM y_user WHERE y_user.username = 'johndoe'),
        (SELECT channel_id
         FROM y_channel
         WHERE channel_name = 'JanesChannel'
           AND user_id = (SELECT user_id FROM y_user WHERE username = 'janedoe'))
    ),
    (
        (SELECT user_id FROM y_user WHERE y_user.username = 'janedoe'),
        (SELECT channel_id
         FROM y_channel
         WHERE channel_name = 'JohnsChannel'
           AND user_id = (SELECT user_id FROM y_user WHERE username = 'johndoe'))
    )
;


-- Insert statements for y_video_view
INSERT INTO y_video_view 
    (user_id, video_id, duration_watched)
VALUES
    (
        (SELECT user_id FROM y_user WHERE y_user.username = 'johndoe'),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        500
    ),
    (
        (SELECT user_id FROM y_user WHERE y_user.username = 'janedoe'),
        (SELECT video_id FROM y_video WHERE y_video.video_id = 2),
        1000
    )
;


-- Insert statements for y_video_category
INSERT INTO y_video_category 
    (video_id, category_id)
VALUES
    (
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        (SELECT category_id FROM y_category WHERE y_category.category_name = 'Programming')
    ),
    (
        (SELECT video_id FROM y_video WHERE y_video.video_id = 2),
        (SELECT category_id FROM y_category WHERE y_category.category_name = 'Arts')
    )
;


-- Insert statements for y_category
INSERT INTO y_category 
    (parent_category_id, category_name)
VALUES
    (
        NULL,
        'Education'
    ),
    (
        NULL,
        'Arts'
    ),
    (
        (SELECT category_id FROM y_category WHERE category_name = 'Education'),
        'Programming'
    )
;


-- Insert statements for y_advertisement
INSERT INTO y_advertisement 
    (title, content, image_url, cta_link, target_audience, click_rate, revenue, budget)
VALUES
    (
        'Tech Ad',
        'Learn coding today!',
        'https://example.com/ad1.jpg',
        'https://example.com/signup',
        'Programmers',
        0.05,
        1000,
        5000
    ),
    (
        'Art Ad',
        'Create amazing art!',
        'https://example.com/ad2.jpg',
        'https://example.com/join',
        'Artists',
        0.03,
        500,
        3000
    )
;


-- Insert statements for y_video_advertisement
INSERT INTO y_video_advertisement 
    (video_id, advertisement_id, ad_type, start_time, end_time)
VALUES
    (
        (SELECT video_id FROM y_video WHERE y_video.video_id = 1),
        (SELECT advertisement_id FROM y_advertisement WHERE advertisement_id = 1),
        'pre',
        0,
        30
    ),
    (
        (SELECT video_id FROM y_video WHERE y_video.video_id = 2),
        (SELECT advertisement_id FROM y_advertisement WHERE advertisement_id = 2),
        'mid',
        600,
        630
    )
;


-- Insert statements for y_ad_impression
INSERT INTO y_ad_impression 
    (advertisement_id, user_id, video_id, clicked, device_type, impression_duration)
VALUES
    (
        (SELECT advertisement_id FROM y_advertisement WHERE advertisement_id = 1),
        (SELECT user_id FROM y_user WHERE y_user.username = 'johndoe'),
        (SELECT video_id FROM y_video WHERE video_id = 2),
        1,
        'desktop',
        10
    ),
    (
        (SELECT advertisement_id FROM y_advertisement WHERE advertisement_id = 2),
        (SELECT user_id FROM y_user WHERE y_user.username = 'janedoe'),
        (SELECT video_id FROM y_video WHERE video_id = 1),
        0,
        'mobile',
        15
    )
;


