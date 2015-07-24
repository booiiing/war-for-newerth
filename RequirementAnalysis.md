Post here anything that you think the application will need in form of an abstract description, a sketch (diagram or handrawn) or any reasonable way of clearly expressing your ideas, trying to avoid technical details. Long items like sketches or samples should be in a separate page with a link and optionally an description here.


## Functional requirements ##
Post here requirements about the working of the site. i.e.:
_The system must have a way to let the users register themselves_:.

  * user management:
    * registering accounts
    * changing details (password, etc)
    * deleting accounts
  * clan management:
    * "importing" a clan (script will check http://clan.savage2clans.com/roster.php and get all the members)
  * match management:
    * choosing a target to attack
    * hinting players on how to set up a match
    * getting the results of a match (merc might provide us xml-data)
  * alliance management:
    * founding alliances (needs a partner)
    * joinin alliances
    * leaving alliances (only one member -> dissolved)
  * war/map management:
    * possibility to view the map (public)
    * views:
      * clan-territories
      * territories of alliances
      * ? beast/human territories (based on which side the owning clan played in the battle for this territory)


---


## Non functional requirements ##
Post here any requirements that have nothing to do with the things that the system should do itself. i.e.:
_The system should recieve player stats and clan info from an official s2 source_ (think of anything that we can't implement ourselves like system conditions, client browser support, etc... but we will have to manage in some way)

  * we need an artist for the map (or maybe we get one from s2games?)
  * site-design/layout
  * connection to savage2-sites:
    * fetch results
    * fetch rosters
  * DetailedRules


---


## Things we require from S2Games ##

  * data of clan-match-results
    * also matches that have been canceled/forfeit/declined with details (to hand out automatic wins)
  * data of clan-members