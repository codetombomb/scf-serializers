
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
    - `bundle add active_model_serializer`
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

## Serializing the Alley Cat app data:

### Category

- Serialize with a `name`
- Serialize with a list of `items` including:
    - `name`, `desc`, `price` in 2 decimal format, with a dollar sign at the beginning i.e. `$10.50`
    - Define a method `#status` that will return 'sold' if self.sold returns true and 'Buy Now' if false.
    - Return the items `seller` with username and email included.

---

### Item

- Serialize with: `name`, `desc`, `price`
- `price` should be in a 2 decimal format, with a dollar sign at the beginning i.e. `$10.50`
- Define a method `#status` that will return 'sold' if self.sold returns true and 'buy now' if false
- Return the items `seller` with username and email included.
- Each item should also return a list of associated `categories` including the name

---

### User

Reminder that user can behave as either a seller and/or buyer. When a request to the users index or show is made, serialized data should return all items that have been purchased and/or sold.

- Serialize with `username` and `email`
- Return a list of both sold_items and purchased_items. These lists should be returned as separate collections.
- Return a list of the categories as `sold_categories` and `purchased_categories`, with only the category `name` included.
