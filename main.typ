#set text(font: "Latin Modern Sans")


```sql
ALTER TABLE [user] ADD CONSTRAINT chk_email_format CHECK ([email] LIKE '%_@_%._%')
GO
```
= Dokumentace databázového modelu YouTube-like platformy


#align(horizon)[
  #figure(
    image("./conceptual_relational_model_cardinal.svg"),
    gap: 6em,
    caption: [Konceptuální relační model]
  )
]



== Popis tabulek 

1. **user**: A record represents a **single user** with personal information such as their username, email, first and last names, registration date, profile picture URL, and additional details like the "about me" section.

2. **channel**: A record represents a **single channel** owned by a user. It contains the channel's name, description, and creation date, along with a reference to the user who owns the channel.

3. **video**: A record represents a **single video** uploaded to a channel. It contains details such as the video title, description, URL, thumbnail, visibility settings, monetization status, upload date, duration, and view count, along with a reference to the channel the video belongs to.

4. **playlist**: A record represents a **single playlist** created by a user. It contains the title of the playlist, the user who created it, and the visibility settings of the playlist, along with its creation date.

5. **playlist_video**: A record represents a **video within a playlist**. It connects a specific video to a specific playlist and stores the date it was added to the playlist.

6. **comment**: A record represents a **single comment** made by a user on a video. It includes the comment content, date, and references to the user who made the comment and the video on which the comment was made. It may also have a parent comment if it's a reply.

7. **reaction**: A record represents a **reaction** by a user to a target item (video, comment, or post). It includes the type of reaction (like, dislike, love), the date it was made, and a reference to the target (video, comment, or post) and user who reacted.

8. **subscription**: A record represents a **subscription** of a user to a channel. It includes a reference to the subscriber (user) and the subscribed channel, along with the user's notification preferences and subscription date.

9. **video_view**: A record represents a **view** of a video by a user. It stores the duration watched, the view date, and references to the video and the user who watched it.

10. **video_category**: A record represents a **category association** for a video. It connects a video to a category, indicating that the video belongs to a particular category.

11. **category**: A record represents a **single category** of videos. It may have a parent category (forming a hierarchical structure) and contains the category's name.

12. **advertisement**: A record represents a **single advertisement** with its content, target audience, image URL, CTA (Call to Action) link, status (active, inactive, expired), click rate, revenue, and budget information.

13. **video_advertisement**: A record represents a **video advertisement** placement. It connects a video to an advertisement, specifying the type of ad (pre-roll, mid-roll, post-roll, or banner) and the start and end times of the ad.

14. **ad_impression**: A record represents an **ad impression** seen by a user on a video. It includes the advertisement, the user who viewed the ad, the video in which the ad appeared, the date and time of the impression, the device used, and whether the ad was clicked.

These descriptions clarify the purpose of each table in your database and the kind of record each one represents.
