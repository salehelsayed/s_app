**Dear Developer,**

Under the "Explore" tab, the content displayed to the user should mirror the layout and interactions seen in the provided image. The idea is to show community-related posts where one user from a community (possibly an admin) is commenting on, referencing, or reacting to content originally posted by another account. The goal is to recreate this style for multiple posts, allowing the user to scroll through them.

Here are detailed instructions:

1. **Overall Structure**:  
   - Display a vertical list (such as a `ListView` or `RecyclerView`) of posts.
   - Each post item should have a distinct layout that includes:
     - Community context and user role (e.g., "Admin" badge if applicable).
     - User’s display name, profile image, and handle.
     - The external content they’re referencing (like another user’s tweet or a shared image).
     - Interactive buttons and metrics (comment, retweet, like, view count, bookmark, share).

2. **Community and User Information (Top Section)**:
   - **Profile Picture**: Include a circular profile avatar of the user who’s posting/commenting. This should be placed on the left side of the post.
   - **Username and Role**:
     - Show the user’s display name (e.g., "Mo") next to or below the avatar.
     - If the user is an admin of the community, display an "Admin" badge next to their name. This badge could be a small, distinct icon or a label to immediately convey the role.
   - **Community Name**:
     - Display the name of the community (e.g., "Kdrama Chingus") in which the user is active.
     - The community name can appear above the post content or as a subtle label near the username, making it clear that this content is sourced from that community context.

3. **Referenced Content (Middle Section)**:
   - **Comment / Post Content**:
     - Include the comment or the text the user ("Mo") wrote. This text should appear as the main body of the post.
   - **External Content Referenced**:
     - Just below the user’s comment, show the referenced post/tweet from another user (e.g., from "K-Drama Handle").
     - This referenced post could be displayed in a contained card-like layout with:
       - The other user’s profile image.
       - Their display name and handle.
       - The text of their original post/tweet.
       - Any attached media (images, videos), if available.
     - Ensure the referenced post stands out visually with subtle borders, rounded corners, or a slightly different background shade, so it’s clear this is shared or quoted content.

4. **Engagement and Interaction Bar (Bottom Section)**:
   - Include interactive icons and counters below the referenced content. These could be arranged in a horizontal row:
     - **Comment Icon & Count**: A speech bubble icon followed by the number of comments. Tapping it could open a comment view.
     - **Retweet or Repost Icon & Count**: A double-arrow or circular arrow icon that allows the user to share or retweet the content. Display a count of how many times it’s been reshared.
     - **Like/Heart Icon & Count**: A heart icon to “like” or “favorite” the post, showing the number of likes.
     - **View Count**: An eye icon or a small label to indicate how many people have viewed the post.
     - **Bookmark Icon**: An icon for saving the post. Tapping it should mark/unmark it as bookmarked.
     - **Share Icon**: A share or export arrow icon to let users share the content externally.

   Make sure these icons are consistent with the rest of the app’s iconography and theming. Use small, clear icons and text that match the font and color palette of the app.

5. **Styling and Theming**:
   - **Background**: The background of the entire screen should match the app’s existing color theme—**do not** use pure black if that’s not part of your standard theme. Use the app’s primary background color (dark, light, or tinted) so everything remains cohesive.
   - **Text and Icons**: Ensure high contrast and legibility. Follow the app’s typographic scale and color schemes.
   - **Spacing and Margins**: Provide consistent spacing around the avatars, text, and interaction icons. Each post should have a small margin separating it from the next.

6. **Scrolling and Multiple Examples**:
   - Create 3 different posts following the above layout so the user can scroll through them.
   - **Variation Ideas**:
     1. **Post #1**: “Mo” (Admin) in "Kdrama Chingus" commenting on a "K-Drama Handle" post. Show a referenced tweet with text and maybe one image, along with some engagement stats.
     2. **Post #2**: Another community admin or a regular member from a different community (e.g., "Anime Haven"), referencing a post from a known anime news handle. Include different comment text, maybe a different set of engagement numbers, and possibly no images in the referenced content.
     3. **Post #3**: A user from a "Tech Enthusiasts" community referencing a tech news tweet. Different user, different community name, and different metrics. Maybe this time show a higher count of likes or retweets, or a bookmarked state by default.

   By having three posts, we can scroll through them and see variations in:
   - Community names.
   - User roles (Admin vs. regular member).
   - Referenced tweet content (with or without images).
   - Different engagement numbers (some posts with more likes, others with fewer).

7. **Interactivity**:
   - Ensure that tapping on any interactive element (comment, retweet, etc.) triggers the appropriate callback or navigation within the app. Even if these are not fully functional yet, set up the structure so they can be integrated with back-end logic later.

## Saleh

Filter Row:

Directly beneath the "Explore" tab, present a horizontal set of filter chips (e.g., “Sports,” “Technology,” “Art,” “Entertainment”).
These filters should match the style and spacing of the application’s existing filter components.
Implement a horizontally scrollable list of these filter tags if they don’t all fit on one screen width.
Selecting a filter should dynamically update the content displayed below.

Key Points:

When the user first clicks on “Explore,” load the default filter set and corresponding initial content.
Tapping a different filter should refresh the displayed content below without reloading the entire screen (i.e., use state management or a dynamic content-loading mechanism).
Maintain visual consistency—use the same background, fonts, and highlight colors as elsewhere in the app.