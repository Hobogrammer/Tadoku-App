The Tadoku App
====

Description
---

The Tadoku application is the webapp for the ReadMOD foreign language reading contest. The application is automatically
managed for the most part using a predefined schedule to know when to allow, and disallow submissions.
The bot portion of the application reads the [TadokuBot](http://twitter.com/TadokuBot) mentions and parses submissions using hastags similar
to a command-line system. After being parsed the bot/app calculates the participants new score based on the language,
medium, and amount read and tweets their new score and rank.

Sample submission tweet

    @TadokuBot 64 #book #zh; 100 #net #jp

Sample tags
  * #book
  * #dr ( for Japanese use only)
  * #manga
  * #net
  * #fullgame
  * #game
  * #lyric
  * #subs
  * #news
  * #nico
  * #sentences
  * #undo
  * #target

A complete list can be found in the [manual](http://readmod.wordpress.com/2011/09/21/a-very-%E5%A4%9A%E8%AA%AD-manual/).

The web application allows users who are not programically inclined to easily submit updates with more easy to use interface.
The application also displays the [rankings](http://readMOD.com/ranking) (current and previous) and shows user's their reading [stats](http://readmod.com/rounds/201308/users/365).

Contributing
----

License
----
