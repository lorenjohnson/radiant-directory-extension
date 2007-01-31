/* General Utlity: QueryString Processing, etc. */ 
function Querystring()
{
// get the query string, ignore the ? at the front.
	var querystring=location.search.substring(1,location.search.length);

// parse out name/value pairs separated via &
	var args = querystring.split('&');

// split out each name = value pair
	for (var i=0;i<args.length;i++)
	{
		var pair = args[i].split('=');

		// Fix broken unescaping
		temp = unescape(pair[0]).split('+');
		name = temp.join(' ');

		temp = unescape(pair[1]).split('+');
		value = temp.join(' ');

		this[name]=value;
	}

	this.get=Querystring_get;
}

function Querystring_get(strKey,strDefault)
{
	var value=this[strKey];
	if (value==null)
	{
		value=strDefault;
	}

	return value;
}