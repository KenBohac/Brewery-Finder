-- Switch to master
USE master;
GO

-- DROP the database if it exists
DROP DATABASE IF EXISTS BreweryDB;
GO

-- Create the db
CREATE DATABASE BreweryDB;
GO

-- Switch to the FlyInventory
USE BreweryDB;
GO

BEGIN TRANSACTION;

CREATE TABLE styles
(
	id				int					identity(1,1),
	name			nvarchar(100)		not null

	constraint		pk_styles_id		primary key(id)
)

CREATE TABLE beers
(
	id				int					identity(1,1),
	name			nvarchar(100)		not null,
	style_id		int					null,
	description		nvarchar(400)		null,
	abv				decimal(4,2)		null,
	imgSrc			nvarchar(500)		null,

	constraint		pk_beer_id			primary key(id),
	constraint		fk_beers_style_id	foreign key(style_id) references styles(id)
)

CREATE TABLE breweries
(
	id				int					identity(1,1),
	name			nvarchar(100)		not null,
	happyHourFrom	Time		            null,
	happyHourTo  	Time		            null,
	established		int					null,
	address			nvarchar(250)		not null,
	city			nvarchar(100)		not null,
	state			varchar(30)			not null,
	zip				int					not null,
	latitude        decimal(8,6)        not null,
	longitude		decimal(8,6)        not null,
	siteURL			nvarchar(100)		null,
	description		nvarchar(1000)		null,
	isBar			bit					null,
	isBrewery       bit					null,
	imgSrc			nvarchar(500)		null,

	constraint		pk_brewery_id		primary key(id)
)

CREATE TABLE beers_breweries 
(
	brewery_id		int							not null,
	beer_id			int							not null

	constraint		pk_beers_breweries			primary key(brewery_id,beer_id)
	constraint		fk_beers_breweries_brewery	foreign key(brewery_id) references breweries(id),
	constraint		fk_beers_breweries_beer		foreign key(beer_id) references beers(id)
)

CREATE TABLE favorites
(
	beer_id			int							not null,
	username		nvarchar(60)				not null

	constraint		pk_favorites				primary key(beer_id,username)
	constraint		fk_favorites_beer			foreign key(beer_id) references beers(id)
)

SET IDENTITY_INSERT styles ON;

INSERT INTO styles (id,name) VALUES (1,'IPA');
INSERT INTO styles (id,name) VALUES (2,'Stout');
INSERT INTO styles (id,name) VALUES (3,'Brown Ale');
INSERT INTO styles (id,name) VALUES (4,'Pilsner')
INSERT INTO styles (id,name) VALUES (5,'Porter')
INSERT INTO styles (id,name) VALUES (6,'Dortmunder')

SET IDENTITY_INSERT styles OFF;

--Sibling Revelry
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Tangelo IPA', 1, 'Big pine flavor with aromas of citrus and stone fruits. Clean, dry finish', 6.6, 'https://gdurl.com/mIsp');
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Cosmic Coaco', 2, 'Brewed with cocoa nibs, aged on oak spirals, spiced with Mexican vanilla for a nice milky finish', 6.6, 'https://gdurl.com/Qzok');
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Pecan Brown Ale', 3, 'Full-bodied American, smooth brown ale brewed with candied pecans, brown sugar, and lactose.', 6.4, 'https://gdurl.com/Znkl');
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Irish Dry Stout', 2, 'Traditional, low gravity Irish stout brewed with barley flakes for added body. Roasted aroma with a little sweet malt. Finishes dry with chocolate undertones.', 4.2, 'https://gdurl.com/IoEK')

--Fatheads
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Head Hunter', 1, 'Head Hunter is an aggressively dry-hopped, West Coast-style IPA with a huge hop display of pine, grapefruit, citrus and pineapple. A brew for those who truly love their hops! Award-Winning.', 7.5, 'https://gdurl.com/l5Pv')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Goggle Fogger', 3, 'The "Hefe" prefix means "with yeast" which gives this unfiltered wheat beer a somewhat cloudy or "foggy" appearance. Light aromas of wheat, bubblegum, clove and spice.', 5, 'https://gdurl.com/9KHj')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Up In Smoke', 5, 'A robust porter brewed with malted barley and coffee. Smoked over Adler wood. Finishes nice and dry.', 9, 'https://gdurl.com/P1m8')

--Market Garden
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Progress', 4, 'Great American Beer Festival Award Winning Brew! Inspired by the Pilsners of the Rhine region, this lager is a tribute to the spicy, crisp and clean character of German noble hops and has just the right malt body to balance.', 4, 'https://gdurl.com/mRIm')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Midnight Vorlauf', 5, 'This beer is brewed with brown, chocolate and crystalized malts then blended with rich and clean cold brewed coffee, yielding a smooth, robust character of a dark Porter.', 6, 'https://gdurl.com/N5R6')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('CitraMax', 1, 'A bold floral and fruity hop profile courtesy of Centennial and Citra hops. Flaked rye and crystal malt provide a nice balance and round mouthfeel, obscuring a high ABV punch.', 9.2, 'https://gdurl.com/nql8')

--GL
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Edmund Fitzgerald', 5, 'Brewed in memory of the sunken freighter with rich, roasted barley with bittersweet chocolate-coffee notes.', 6, 'https://gdurl.com/QfQG')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Dortmunder', 6, 'A smooth, award-winning (and deceptively unassuming) balance of sweet malt and dry hop flavors. Smooth. Balanced. Charmingly unpretentious.' , 5.8, 'https://gdurl.com/d9mC')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Chillwave', 1, 'Earthy, tropical Mosaic hops ride frontside here, followed by a deft cutback of sweet honey malt.', 9.1, 'https://gdurl.com/f31M')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Blackout Stout', 2, 'Pitch-dark and rich Imperial Stout. Kindled with black malt and roasted barley. Illuminated by flickers of bitter hops.', 9.9, 'https://gdurl.com/E-VI')

--Willoughby
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Peanut Butter Cup', 2, 'this stout has layers of chocolate, mocha and caramel all heightened by the heavy handed addition of locally roasted coffee.', 5.5, 'https://gdurl.com/XZ-X')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Community', 4, 'Simple, bready malts and a healthy dose of American and European Noble hops combine in a beer that truly anyone can enjoy.', 5, 'https://gdurl.com/sQiR')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Nut Smasher', 2, 'Award-winning Imperial Stout. Seven types of malts. Infused with fresh-roasted coffee, chocolate and peanut butter. Rich, ebony pour with light brown head.', 11.5, 'https://gdurl.com/TSas') 

--Thirsty Dog
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Siberian Night', 2, 'Very dark, rich, creamy and full-bodied Russian Imperial Stout whose complex character from generous amounts of roasted, toasted, and caramel malts.', 8.9, 'https://gdurl.com/XcLc')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Old LegHumper', 5, 'This dark brown, robust porter is full bodied with a deep roasted, silky smooth, malty sweet taste.', 5.5, 'https://gdurl.com/Gt_d')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Citra Dog', 1, 'You�ll find evidence of tangerine, grapefruit, orange and mango in the flavor and aroma from the multiple addition of a single hop variety, Citra.', 6.8, 'https://gdurl.com/S1Rk')

--Hoppin Frog
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('BORIS Imperial Stout', 2, 'This Bodacious Oatmeal Russian Imperial Stout will crush you like no other! This is the grand-daddy of all stout styles, with an intensely deep roasted and full bodied flavor. A robust hop character adds a refreshing balance.', 9.4, 'https://gdurl.com/NxSy')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Silk Porter', 5, 'Dark, robust and silky-smooth, with many flavors of roasted, toasted and caramel malts. Porter is an old-world beer style that fueled the industrial revolution.', 6.5, 'https://doc-0s-ak-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/ln5c2rjdtsi5eunjdkqkh1rlp94pabs9/1555524000000/07855601184608224584/*/16jpPF8vDeclNnMQepLNkP83JuKbiJTNK ')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Gangster Frog IPA', 1, 'Crisp and satisfying American I.P.A. with a skillfully assertive American hop aroma & flavor. Bright spicy citrus hop character up front, with a distinct orange & tropical fruit bouquet to add a welcome complexity & strike the perfect balance.', 7.5, 'https://doc-0s-ak-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/ln5c2rjdtsi5eunjdkqkh1rlp94pabs9/1555524000000/07855601184608224584/*/16jpPF8vDeclNnMQepLNkP83JuKbiJTNK')

--Boss Dog
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Dog Pound Brown', 3, 'Traditional brown ale enlivened with nutty biscuit and mild chocolate aromas.', 6.2, 'https://doc-0s-ak-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/brh918c91gqdk5ncm768doa0ksonl64h/1555531200000/07855601184608224584/*/16jpPF8vDeclNnMQepLNkP83JuKbiJTNK')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Cuyahoga Porter', 5, 'Robust and roasted. Slight sweetness a touch of chocolate', 5.8, 'https://doc-0s-ak-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/brh918c91gqdk5ncm768doa0ksonl64h/1555531200000/07855601184608224584/*/16jpPF8vDeclNnMQepLNkP83JuKbiJTNK')
INSERT INTO beers (name, style_id, description, abv, imgSrc) VALUES ('Buck IPA', 1, 'Deep piney, resinous flavor augmented by sweet melon.', 7.2, 'https://doc-0s-ak-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/brh918c91gqdk5ncm768doa0ksonl64h/1555531200000/07855601184608224584/*/16jpPF8vDeclNnMQepLNkP83JuKbiJTNK')




INSERT INTO breweries (name, happyHourFrom, happyHourTo, established, address, city, state, zip, latitude, longitude, siteURL, description, isBar, isBrewery, imgSrc) Values ('Great Lakes Brewing', '16:00', '19:00', 1986, '2516 Market Ave', 'Cleveland', 'Ohio', 44113, 41.484417, -81.704427, 'www.greatlakesbrewing.com', 'Great Lakes Brewing Company is a brewery and brewpub in Cleveland, Ohio. The first brewpub and microbrewery in the state, Great Lakes Brewing has been noted as important to Cleveland''s local identity and as one of the initial forces behind the revival of the Ohio City neighborhood on Cleveland''s near West Side.', 1, 1, 'https://gdurl.com/x0vv') 
INSERT INTO breweries (name, happyHourFrom, happyHourTo, established, address, city, state, zip, latitude, longitude, siteURL, description, isBar, isBrewery, imgSrc) Values ('Thirsty Dog Brewery', '17:00', '20:00', 1997, '1075 Old River Road', 'Cleveland', 'Ohio', 44113, 41.499552, -81.706312, 'www.thirstydog.com', 'Each of our Thirsty Dog''s beers are meticulously hand crafted in small batches using the finest ingredients. High quality malted barley is the source of the beer''s sweetness & body. Select American & European hops are used to balance the malt sweetness, and , at times, add special flavors & aromas to the beer. Our careful selection of ingredients, along with specially designed recipes & brewing processes, give Thirsty Dog beers their unique flavor profiles that can be hard to find in today''s mass market. one size fits all society.', 1,1, 'https://gdurl.com/dwp7')
INSERT INTO breweries (name, happyHourFrom, happyHourTo, established, address, city, state, zip, latitude, longitude, siteURL, description, isBar, isBrewery, imgSrc) Values ('Willoughby Brewing Co.', '16:00', '19:00', 1995, '4057 Erie St.', 'Willoughby', 'Ohio', 44094, 41.641522, -81.405490, 'www.willoughbybrewing.com', 'Nestled in the heart of Historic Downtown Willoughby, Ohio lies Willoughby Brewing Co. Established in February of 1998, we are a full-service restaurant, bar and award-winning brewery in a 100-year-old building that was originally a rail-car repair depot for the Cleveland to Ashtabula Interurban Rail Line.',1,1, 'https://gdurl.com/736M')
INSERT INTO breweries (name, happyHourFrom, happyHourTo, established, address, city, state, zip, latitude, longitude, siteURL, description, isBar, isBrewery, imgSrc) Values ('Sibling Revelry Brewery', null, null, 1995, '29305 Clemens Road', 'Westlake', 'Ohio', 44145, 41.470402, -81.946201, 'www.siblingrevelrybrewing.com', 'Sibling Revelry Brewing was founded by a family of brothers and cousins from Cleveland who wanted to share their passion for great beer with others. ... Pair beers with a rotating selection of food trucks with great foods like sandwiches, burgers, and more.',1,1, 'https://gdurl.com/7XTD')
INSERT INTO breweries (name, happyHourFrom, happyHourTo, established, address, city, state, zip, latitude, longitude, siteURL, description, isBar, isBrewery, imgSrc) Values ('Market Garden Brewery', null, null, 2011, '1947 W 25TH ST', 'Cleveland', 'Ohio', 44113, 41.484896, -81.703650,'www.marketgardenbrewery.com', 'Market Garden Brewery,  located next door to the 100 year old West Side Market, has been stocked with a lineup of tasty, session beers like our award-winning Progress Pilsner, our organically hopped Citramax IPA, as well as Prosperity, our Bavarian style Hefeweizen, since 2011.',1,1, 'https://gdurl.com/aSC0')
INSERT INTO breweries (name, happyHourFrom, happyHourTo, established, address, city, state, zip, latitude, longitude, siteURL, description, isBar, isBrewery, imgSrc) Values ('Fat Head''s Brewery', '14:00', '18:00', 2009, '17450 Engle Lake Dr', 'Middleburg Hts.', 'Ohio' , 44143, 41.377386, -81.822942, 'www.fatheads.com', 'Brewmaster Matt Cole partnered with Glenn Benigni, owner of Fat Head''s Saloon in Pittsburgh, Pennsylvania, to open Fat Head''s Brewery & Saloon in Cleveland, Ohio in 2009. They grew to be known for their selection of craft beer and large sandwiches, called "headwiches."',1,1, 'https://gdurl.com/gY0X')
INSERT INTO breweries (name, happyHourFrom, happyHourTo, established, address, city, state, zip, latitude, longitude, siteURL, description, isBar, isBrewery, imgSrc) Values ('Hoppin'' Frog Brewery', '16:00', '19:00', 2006, '2572 Scraton Road', 'Cleveland', 'Ohio', 44113, 41.477156, -81.695125, 'www.hoppinfrog.com', 'Hoppin'' Frog Brewery is a small, hands-on brewery in Akron, Ohio making very flavorful beers in the most flavorful styles. We brew the highest quality beer with an uncompromising focus on detail, from the ingredient selection to the brewing process.', 1, 1, 'https://gdurl.com/2tnW')
INSERT INTO breweries (name, happyHourFrom, happyHourto, established, address, city, state, zip, latitude, longitude, siteUrl, description, isBar, isBrewery, imgSrc) Values ('Boss Dog Brewery', null, null, 2016, '2179 Lee Rd.', 'Cleveland Heights', 'Ohio', 44118, 41.500306, -81.565296, 'www.bossdogbrewing.com', 'Owners Josh and Jason Sweet transformed a tired restaurant space in Cleveland Heights into a lively, modern brewery and pub that showcases their craft. Boss Dog offers a welcoming environment for guests who want to experience the a constantly changing menu of handcrafted brews.', 1, 1, 'https://doc-0k-ak-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/v5ag0nrahel7onj3rnukbqr8p0kd2ns1/1555531200000/07855601184608224584/*/1bxxM31Y5_y5VESgNciUMMiJKYnsVKWhm')
INSERT INTO breweries (name, happyHourFrom, happyHourto, established, address, city, state, zip, latitude, longitude, siteUrl, description, isBar, isBrewery, imgSrc) Values ('BrewNuts', null, null, 2016, '6501 Detroit Ave.', 'Cleveland', 'Ohio', 44102, 41.483894, -81.730469, 'www.brewnutscleveland.com', 'Part bar, part donut shop, this hip Detroit-Shoreway spot pairs beer-based donuts (think Hefeweizen-spiked banana cream, ginger glazed with gooseberry-IPA jam), with craft beer and artisanal coffee.', 1, 0, "")
INSERT INTO breweries (name, happyHourFrom, happyHourto, established, address, city, state, zip, latitude, longitude, siteUrl, description, isBar, isBrewery, imgSrc) VALUES ('Moosehead Saloon', '18:00', '21:00', 1994, '694 Dover Center Rd.', 'Westlake', 'Ohio', 44145, 41.476845,-81.921259,'www.mooseheadrestaurant.com', 'Located where Westlake meets Bay, the Moosehead offers a menu of homemade classics paired with local craft beers.',  1, 0, "")

INSERT INTO beers_breweries Values (1, 11 )
INSERT INTO beers_breweries Values (1, 12 )
INSERT INTO beers_breweries Values (1, 13 )
INSERT INTO beers_breweries Values (1, 14 )

INSERT INTO beers_breweries Values (3, 15 )
INSERT INTO beers_breweries Values (3, 16 )
INSERT INTO beers_breweries Values (3, 17 )
INSERT INTO beers_breweries Values (4, 1 )
INSERT INTO beers_breweries Values (4, 2 )
INSERT INTO beers_breweries Values (4, 3 )
INSERT INTO beers_breweries Values (4, 4 )
INSERT INTO beers_breweries Values (5, 8 )
INSERT INTO beers_breweries Values (5, 9 )
INSERT INTO beers_breweries Values (5, 10 )
INSERT INTO beers_breweries Values (6, 5 )
INSERT INTO beers_breweries Values (6, 6 )
INSERT INTO beers_breweries Values (6, 7 )
INSERT INTO beers_breweries Values (2, 18 )
INSERT INTO beers_breweries Values (2, 19)
INSERT INTO beers_breweries Values (2, 20)
INSERT INTO beers_breweries Values (7, 21)
INSERT INTO beers_breweries Values (7, 22)
INSERT INTO beers_breweries Values (7, 23)
INSERT INTO beers_breweries Values (8, 24)
INSERT INTO beers_breweries Values (8, 25)
INSERT INTO beers_breweries Values (8, 26)
INSERT INTO beers_breweries Values (9,6)
INSERT INTO beers_breweries Values (9,4)
INSERT INTO beers_breweries Values (9,10)
INSERT INTO beers_breweries Values (9,18)
INSERT INTO beers_breweries VALUES (10, 7)
INSERT INTO beers_breweries VALUES (10, 4)
INSERT INTO beers_breweries VALUES (10, 16)
INSERT INTO beers_breweries VALUES (10,9)

COMMIT;


select * from beers
select * from beers_breweries
select * from breweries