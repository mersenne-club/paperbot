Hi everyone! I’m *looking for help* (Julia, web dev) building a forum to discuss preprints. Let me explain.

For many (all?) of us, the main source of scientific information is the arXiv/bioRxiv preprint server. But what is the point of writing and reading papers if not to talk about them? We all do that in journal clubs, lab meetings and conferences, but I have long felt that an online forum to discuss papers is missing. 

When I have read a paper, there is no place I can go to confront my understanding of it with other readers: discuss scope and limitations of the work, point out errors if any, brainstorm new directions, perhaps even find potential collaborators. I would love there to be such a place. Wouldn’t you?

So I've created a Discourse forum to fill this gap, here:

https://discourse.mersenne.club

Each day, a bot pulls new preprints from arXiv.org and bioRxiv.org and posts them in the forum as new discussion topics. Users can comment on papers (Markdown, LaTeX), tag each other, engage in private messaging. 

I've coded the bot in Julia, (here)[https://github.com/mersenne-club/paperbot]. I'm a physicist without previous experience with HTTP etc, so the codebase is very imperfect. Which is why I'm calling for help.  

I am hoping some of you will have a look at the site and share their impressions with me, and that a 1 or 2 strong coders more will offer their help to make this a fully functional web service. If the concept proves compelling, my plan is to pitch the server to the Max Planck Society (I'm a group leader at MPI Mathematics in the Sciences), and work with them towards opening it to the whole research community. Cornell University made a very good contribution to science when they accepted to host arXiv.org. I hope MPG can make a similar contribution by sponsoring a service such as the "Mersenne Club". (That's how I've provisionally called the service, from (Marin Mersenne)[https://en.wikipedia.org/wiki/Marin_Mersenne].) 

I’m looking forward to hearing from you!

All the best,
Matteo