# Todo
- 'Remember' variable selection from pre-factor to factor
- Load and save state where you can choose the file to load and where to save the sate files. Should this be an rda file with two components?

# Turn Radiant into a package! Use import and all the other good stuff. Start with 

http://adv-r.had.co.nz/

# default values for things like plot size, ...

# Memory:
- Do the variables values need to be stored in a reactive? Does it matter?
- Reset incase you didn't actually want the remembered settings

# Merge and join of datasets!

# Perhaps for iRadiant?
- http://plugins.jquery.com/autosize/
- Have the code from the text area be prosesed by knitr? That should produce html that can be shown without renderPrint etc.
- Needs a button to (1) add a command textArea and (2) a markdown box. How does ipython then allow you to edit and display the markdown? Do you need an edit checkbox or something?

# Logging:
- Now that the settings are known you should be able to 'log' output in a separate tab.
- Calling the appropriate reactive with the parameters available
- This, together with iRadiant, would be great for students to write assignments, exams, and reports.

Dynamic filters for View, Visualize, and Explore. Depending on what variable is selected a control pops up
- For numeric a range slider
- For factor a check box list
- For date a slider with a time-line

What if you select multiple filter variables? I guess you could put up a selectInput for numeric/date/factor separately. If a variable is selected then the appropriate control is created.

Discussion on dynamic input-elements:
https://groups.google.com/forum/?fromgroups=#!searchin/shiny-discuss/dynamic$20filter/shiny-discuss/je4zKWw0lBk/uAFCcVeulbEJ

(d)plyr:

- Using plyr until dplyr can be used as either (1) a substitute for plyr or (2) together with plyr
- Merge and join in dplyr / plyr to link data.
- Access through a dbase (e.g., sqlite) to allow working with bigger datasets in chunks

<!-- To implement a filter on the data for all analyses put something in the getdata() function. By the way ... shouldn't that be a reactive function? Especially if you apply a filter right? -->

Visualize: more plotting options
- Change fonts sizes
- Change plot style (e.g., line, bar, etc.)

Improve look of regression (etc.) output (i.e., the look of the Summary tab)
http://www.r-bloggers.com/pander-0-3-8-is-out/
http://www.r-bloggers.com/how-to-put-your-meetup-on-the-map-literally/
http://www.r-bloggers.com/interactive-3d-in-shiny-shinyrgl/
https://groups.google.com/forum/?fromgroups=#!searchin/shiny-discuss/dynamic$20filter/shiny-discuss/je4zKWw0lBk/uAFCcVeulbEJ
https://groups.google.com/forum/#!topic/shiny-discuss/hzYGDJQF_e4
http://vita.had.co.nz/papers/tidy-data.pdf


# select on date?
as.Date('2000-01-01')
