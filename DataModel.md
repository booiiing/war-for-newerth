## Data model design ##

Here we will describe the entities that will conform the data model.

On the svn folder wiki/DataModel there is a [Dia](http://projects.gnome.org/dia/) diagram with the preliminary model that you can download and modify.


The curren state of the model is

![http://war-for-newerth.googlecode.com/svn/wiki/DataModel/war-for-newerth-dm.png](http://war-for-newerth.googlecode.com/svn/wiki/DataModel/war-for-newerth-dm.png)

We will define the following entities

  * **Clan**
> Defining a clan identified by the clan name and and tag. Might have other attributes in the future like personal clan webpage.

  * **Alliance**
> Relationship between 0 or more _Clan_ s

  * **User**
> Each user of the system, registered by a login and a password. Each user will belong to a single _Clan_ .

  * **Territory**
> A territory on the map, defined by its shape (or some other geometry type) and the corresponding map name. Each territory belongs to one or none _Clan_ .

  * **Match**
> A fight for a territory. Each match will belong to two or more (only 2 in practice) _Clan_ s, will have one or none _Clan_ as winner (depending on the number of games per match, we have to specify this), and a roster of _User_ s