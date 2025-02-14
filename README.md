# 🍕 Fetch Recipe Take-Home

### Summary: Include screen shots or a video of your app highlighting its features
<p>
  <img
    src="https://github.com/user-attachments/assets/3f69b410-ad9d-445d-98be-328dd836c3df"
    alt="Simulator Screenshot 1"
    width="300"
    style="margin-right:10px;"
  />
  <img
    src="https://github.com/user-attachments/assets/2c0efc5d-cb3a-4a84-b08a-e84b22cf9a85"
    alt="Simulator Screenshot 2"
    width="300"
    style="margin-right:10px;"
  />
  <img
    src="https://github.com/user-attachments/assets/04a2b7fa-1bb5-46bd-97d0-d518f81b42fa"
    alt="Simulator Screenshot 3"
    width="300"
    style="margin-right:10px;"
  />

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
---------------------------------------------------------------------------------------------------------------------
I decided to emphasize the project's architecture rather than the UI layer. I used a proven combination of the service locator pattern, MVVM, and dependency injection (DI). If third-party libraries were permitted, I would have integrated something like Swinject or Factory.
Focusing on architecture provided a strong foundation for scalability and testability. It makes it easier to extend the project with new features without compromising maintainability or speed of development. I believe this approach balances velocity with building something meaningful.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
---------------------------------------------------------------------------------------------------------------------
I spent approximately 4 hours on this take-home project:

* 2–3 hours on the infrastructure layer: setting up services and plumbing, defining the core components and their interactions.
* 1 hour on the UI: creating a basic interface and demonstrating a simple design system that I like to include in all projects.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
---------------------------------------------------------------------------------------------------------------------
If I had been allowed to use third-party libraries, I would have taken a slightly different path. For instance, using Swinject or Factory would have enabled more robust container-based DI for services and view models, further enhancing testability and making it easier to mock dependencies and swap implementations as needed.
Additionally, I would have preferred to rely on an industry-standard image-caching library (like Nuke or Kingfisher) rather than rolling my own solution. These libraries are well-maintained, battle-tested, and would reduce the burden of managing image caching and memory usage manually.

### Weakest Part of the Project: What do you think is the weakest part of your project?
---------------------------------------------------------------------------------------------------------------------
The biggest shortcoming is the memory usage incurred by caching all images at once. Ideally, I would implement paging or a more efficient image-loading strategy—especially if the endpoint supported pagination.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
---------------------------------------------------------------------------------------------------------------------
Thank you for the opportunity to work on this project. I appreciate the chance to showcase my approach and would be happy to walk through any part of the code or answer any questions you might have.
-🤘🏼
