# Book Search

This cleverly named application is a Ruby on Rails API built to search and filter books using the [OpenLibrary.org](https://openlibrary.org/dev/docs/api/search) API.

The app is currently hosted on Heroku: [https://sheltered-fjord-62597.herokuapp.com](https://sheltered-fjord-62597.herokuapp.com) - In postman/browser/similar app you can use the aforementioned URL + endpoint + desired parameters. See below for examples.


## Usage

| Param    | Required? | Input               | Example                                                 | Note                                                 |
|----------|-----------|---------------------|---------------------------------------------------------|------------------------------------------------------|
| title    | yes*      | string              | api/v1/search?title=american+gods                       |                                                      |
| author   | yes*      | string              | api/v1/search?author=gaiman                             |                                                      |
| sort_by  | no        | 'title' or 'author' | api/v1/search?author=gaiman&sort_by=title               | if not entered, results will sort by title           |
| order_by | no        | 'asc' or 'desc'     | api/v1/search?author=gaiman&sort_by=title&order_by=desc | if not entered, results will sort by ascending (asc) |

__*Either title or author has to be used in the search, otherwise you will receive a 400 error code. Both can be used, but at least one must be specified__

### Returned Values

The returned JSON returns basic search results. The following keys are returned:

`"is_search_unique"`: this key returns a boolean and informs the user if the combined search params for author and title are previously unsearched. Future development will see this value used for response caching.

`"books"`: this key returns an array of the searched results. Nested objects include the title of the found work ('title': 'American Gods') and an array of authors (author: ['Neil Gaiman'])

### Examples
`https://sheltered-fjord-62597.herokuapp.com/api/v1/search?title=american+gods` returns:
```json
{
    "is_search_unique": true,
    "books": [
        {
            "title": "\"African American Men Struggle to Seek God\"",
            "author": [
                "Melba Eldridge-Lewis"
            ]
        },
        {
            "title": "\"From American Dream to God's Destiny\"",
            "author": [
                "Robert, Louis Huber"
            ]
        }...
```

`https://sheltered-fjord-62597.herokuapp.com/api/v1/search?title=american+gods&author=gaiman` returns:
```json
{
    "is_search_unique": false,
    "books": [
        {
            "title": "American Gods",
            "author": [
                "Neil Gaiman"
            ]
        },
        {
            "title": "American Gods",
            "author": [
                "Neil Gaiman"
            ]
        }...
```

`https://sheltered-fjord-62597.herokuapp.com/api/v1/search?author=gaiman&sort_by=title` returns:
```json
{
    "is_search_unique": false,
    "books": [
        {
            "title": "A Game of You",
            "author": [
                "Neil Gaiman"
            ]
        },
        {
            "title": "Absolute Sandman Vol. 5.",
            "author": [
                "Neil Gaiman"
            ]
        }...
```

`https://sheltered-fjord-62597.herokuapp.com/api/v1/search?author=gaiman&sort_by=title&order_by=desc` returns:
```json
{
    "is_search_unique": false,
    "books": [
        {
            "title": "Zerbrechliche Dinge",
            "author": [
                "Neil Gaiman"
            ]
        },
        {
            "title": "Worlds' End",
            "author": [
                "Neil Gaiman"
            ]
        }...
```

## Getting Started in Development

See below to get started.

### Prerequisites

Note: Book Search is built using Rails 5.2.4 and Ruby 2.6.3. To ensure you have these versions installed, run:

```
$ ruby -v
```

You should see a response similar to:

```
ruby 2.6.3
```

and if running

```
$ rails -v
```

response:

```
Rails 5.2.4
```

If neither are installed, this [tutorial](http://railsapps.github.io/installrubyonrails-mac.html) is an excellent source to get you up and running on macOS.



### Installing

1) Fork and then clone this repository to your local machine

```
$ git clone https://github.com/mdevoe12/book_search.git
```

2) Change directories to the newly cloned down repo

```
$ cd book_search
```

3) Once in the directory, bundle:
   (this may take a bit of time)

```
$ bundle
```

4) Create the database (Postgres is used for Book Search):

```
$ rake db:create
```

5) Migrate the database:

```
$ rake db:migrate
```

6) To launch this application in development, run:

```
$ rails s
```

7) When using development, you can use the above described endpoints. However, instead of using the Heroku URL, use [localhost:3000](localhost:3000).

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
