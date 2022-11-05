
# 11-5 Rails Serializers

### What is serialization?

ActiveModel::Serializer, or AMS, provides a convention-based approach to serializing resources or shaping our data to fit our needs.

### How have we been serializing up to this point?

- In Rails controllers, we have been using `render json:` and in Sinatra, we used the `to_json` method and passed any options to customize data or include data associations.

### When to use AMS over controller serialization?

- More commonly, we want to include AMS when data structures become complex and require a lot of customization.
- Best practice for separation of concerns tells us we should always use AMS to isolate the responsibility of serialization from the controllers.

### How to use AMS

- Add gem to Gemfile:

```bash
gem 'active_model_serializers'
```

- And then run `bundle install`
- or run:
    - `bundle add active_model_serializers`
- To generate a new serializer, run serializer generator:

```bash
rails g serializer <serializer_name> #use singular naming here
```

If convention is followed, serializers will match the respective model object.

```ruby
def show
	render json: category
	# this will invoke upon the CategorySerializer for a single instance
end
```

To serialize a collection with a custom serializer, the `each_serializer` method can be used to pass each instance to the serializer:

```ruby
def index
  categories = Category.all
  render json: categories, each_serializer: CustomSerializer
end
```

## Serializing the Alley Cat app data
[Alley Cat Antiques ERD](https://drive.google.com/file/d/1JYWBbN5QuhdJqAk9vZFBVS4q204o4umU/view?usp=sharing)

### Category

- Serialize with a `name`
- Serialize with a list of `items` including:
    - `name`, `desc`, `price` in 2 decimal format, with a dollar sign at the beginning i.e. `$10.50`
    - Define a method `#status` that will return 'sold' if self.sold returns true and 'Buy Now' if false.
    - Return the items `seller` with username and email included.

```json

[
  {
    "id": 1,
    "name": "fishing",
    "items": [
      {
        "id": 1,
        "name": "fishing pole",
        "desc": "really cool fishing pole!",
        "price": "$10.00",
        "status": "Buy Now"
      }
    ]
  },
  {
    "id": 2,
    "name": "camping",
    "items": [
      {
        "id": 1,
        "name": "fishing pole",
        "desc": "really cool fishing pole!",
        "price": "$10.00",
        "status": "Buy Now"
      }
    ]
  },
  {
    "id": 3,
    "name": "womens clothing",
    "items": [
      {
        "id": 2,
        "name": "white t",
        "desc": "get hip with this cool shirt",
        "price": "$5.00",
        "status": "Buy Now"
      }
    ]
  },
  {
    "id": 4,
    "name": "mens clothing",
    "items": [
      {
        "id": 2,
        "name": "white t",
        "desc": "get hip with this cool shirt",
        "price": "$5.00",
        "status": "Buy Now"
      }
    ]
  },
  {
    "id": 5,
    "name": "electronics",
    "items": [
      {
        "id": 5,
        "name": "vintage walkman",
        "desc": "go back in time with this music player",
        "price": "$5.25",
        "status": "Buy Now"
      }
    ]
  },
  {
    "id": 6,
    "name": "decor",
    "items": [
      {
        "id": 3,
        "name": "gold round mirror",
        "desc": "vintage mirror",
        "price": "$30.50",
        "status": "Buy Now"
      },
      {
        "id": 4,
        "name": "marble table lamp",
        "desc": "really cool marble lamp",
        "price": "$27.50",
        "status": "Buy Now"
      }
    ]
  },
  {
    "id": 7,
    "name": "home",
    "items": [
      {
        "id": 3,
        "name": "gold round mirror",
        "desc": "vintage mirror",
        "price": "$30.50",
        "status": "Buy Now"
      },
      {
        "id": 4,
        "name": "marble table lamp",
        "desc": "really cool marble lamp",
        "price": "$27.50",
        "status": "Buy Now"
      }
    ]
  },
  {
    "id": 8,
    "name": "living room",
    "items": [
      {
        "id": 3,
        "name": "gold round mirror",
        "desc": "vintage mirror",
        "price": "$30.50",
        "status": "Buy Now"
      },
      {
        "id": 4,
        "name": "marble table lamp",
        "desc": "really cool marble lamp",
        "price": "$27.50",
        "status": "Buy Now"
      }
    ]
  }
]
```

---

### Item

- Serialize with: `name`, `desc`, `price`
- `price` should be in a 2 decimal format, with a dollar sign at the beginning i.e. `$10.50`
- Define a method `#status` that will return 'sold' if self.sold returns true and 'buy now' if false
- Return the items `seller` with username and email included.
- Each item should also return a list of associated `categories` including the name

```json

[
  {
    "id": 1,
    "name": "fishing pole",
    "desc": "really cool fishing pole!",
    "price": "$10.00",
    "status": "Buy Now",
    "seller": {
      "id": 1,
      "username": "codetombomb",
      "email": "codetombomb@gmail.com"
    },
    "categories": [
      {
        "id": 1,
        "name": "fishing"
      },
      {
        "id": 2,
        "name": "camping"
      }
    ]
  },
  {
    "id": 2,
    "name": "white t",
    "desc": "get hip with this cool shirt",
    "price": "$5.00",
    "status": "Buy Now",
    "seller": {
      "id": 1,
      "username": "codetombomb",
      "email": "codetombomb@gmail.com"
    },
    "categories": [
      {
        "id": 3,
        "name": "womens clothing"
      },
      {
        "id": 4,
        "name": "mens clothing"
      }
    ]
  },
  {
    "id": 3,
    "name": "gold round mirror",
    "desc": "vintage mirror",
    "price": "$30.50",
    "status": "Buy Now",
    "seller": {
      "id": 2,
      "username": "eriiscool",
      "email": "eriiscool@gmail.com"
    },
    "categories": [
      {
        "id": 6,
        "name": "decor"
      },
      {
        "id": 7,
        "name": "home"
      },
      {
        "id": 8,
        "name": "living room"
      }
    ]
  },
  {
    "id": 4,
    "name": "marble table lamp",
    "desc": "really cool marble lamp",
    "price": "$27.50",
    "status": "Buy Now",
    "seller": {
      "id": 2,
      "username": "eriiscool",
      "email": "eriiscool@gmail.com"
    },
    "categories": [
      {
        "id": 6,
        "name": "decor"
      },
      {
        "id": 8,
        "name": "living room"
      },
      {
        "id": 7,
        "name": "home"
      }
    ]
  },
  {
    "id": 5,
    "name": "vintage walkman",
    "desc": "go back in time with this music player",
    "price": "$5.25",
    "status": "Buy Now",
    "seller": {
      "id": 2,
      "username": "eriiscool",
      "email": "eriiscool@gmail.com"
    },
    "categories": [
      {
        "id": 5,
        "name": "electronics"
      }
    ]
  }
]

```

---

### User

Reminder that user can behave as either a seller and/or buyer. When a request to the users index or show is made, serialized data should return all items that have been purchased and/or sold.

- Serialize with `username` and `email`
- Return a list of both sold_items and purchased_items. These lists should be returned as separate collections.
- Return a list of the categories as `sold_categories` and `purchased_categories`, with only the category `name` included.


```json

[
  {
    "id": 1,
    "username": "codetombomb",
    "email": "codetombomb@gmail.com",
    "purchased_items": [
      {
        "id": 5,
        "name": "vintage walkman",
        "desc": "go back in time with this music player",
        "price": "$5.25",
        "status": "Buy Now"
      }
    ],
    "sold_items": [
      {
        "id": 1,
        "name": "fishing pole",
        "desc": "really cool fishing pole!",
        "price": "$10.00",
        "status": "Buy Now"
      },
      {
        "id": 2,
        "name": "white t",
        "desc": "get hip with this cool shirt",
        "price": "$5.00",
        "status": "Buy Now"
      }
    ],
    "sold_categories": [
      {
        "id": 1,
        "name": "fishing"
      },
      {
        "id": 2,
        "name": "camping"
      },
      {
        "id": 3,
        "name": "womens clothing"
      },
      {
        "id": 4,
        "name": "mens clothing"
      }
    ],
    "purchased_categories": [
      {
        "id": 5,
        "name": "electronics"
      }
    ]
  },
  {
    "id": 2,
    "username": "eriiscool",
    "email": "eriiscool@gmail.com",
    "purchased_items": [
      
    ],
    "sold_items": [
      {
        "id": 3,
        "name": "gold round mirror",
        "desc": "vintage mirror",
        "price": "$30.50",
        "status": "Buy Now"
      },
      {
        "id": 4,
        "name": "marble table lamp",
        "desc": "really cool marble lamp",
        "price": "$27.50",
        "status": "Buy Now"
      },
      {
        "id": 5,
        "name": "vintage walkman",
        "desc": "go back in time with this music player",
        "price": "$5.25",
        "status": "Buy Now"
      }
    ],
    "sold_categories": [
      {
        "id": 6,
        "name": "decor"
      },
      {
        "id": 7,
        "name": "home"
      },
      {
        "id": 8,
        "name": "living room"
      },
      {
        "id": 6,
        "name": "decor"
      },
      {
        "id": 8,
        "name": "living room"
      },
      {
        "id": 7,
        "name": "home"
      },
      {
        "id": 5,
        "name": "electronics"
      }
    ],
    "purchased_categories": [
      
    ]
  }
]
```

