# A Ruby gem to load environment variables from `.env`.

Samples and use cases for working with `dotenv` gem.

## Default.load will load your application configuration from your `.env` file found in the project root:

### Usage

Dotenv.load

### Outcome

- returns a hash with environment values
- updates ENV["variables"] with environment values

## Dotenv load with simple key/values

### Usage

Dotenv.load('simple.env')

### Outcome

- set simple environment variables
- supports exported environment variables

---

```ruby
module Dotenv
  def load(*filenames)
    with(*filenames) do |f|
      ignoring_nonexistent_files do
        env = Environment.new(f, true)
        instrument("dotenv.load", env: env) { env.apply }
      end
    end
  end
end
```

## Dotenv load with multiline values

### Usage

Dotenv.load('multiline.env')

### Outcome

- set environment variable with values mixed with line feeds
- set environment variable with multiline values

---

```bash
MULTI_LINE_KEY1="-----BEGIN RSA PRIVATE KEY-----\nKEY-1\n-----END DSA PRIVATE KEY-----\n"
MULTI_LINE_KEY2="-----BEGIN RSA PRIVATE KEY-----
...
KEY-2
...
-----END DSA PRIVATE KEY-----"
```

## Dotenv load with quoted values

### Usage

Dotenv.load('quoted.env')

### Outcome

- converts all values to string
- handles empty values as ''
- will escape single quote LF - '\n' to '\\n'
- will not alter double quote LF - "\n"

---

```bash
QUOTED=true
OPTION_1=1
OPTION_2='2'
OPTION_3="3"
BLANK_1=
BLANK_2=''
BLANK_3=""
OPTION_G='\n\n\n'
OPTION_H="\n\n\n"
```

---

{
"QUOTED": "true",
"OPTION_1": "1",
"OPTION_2": "2",
"OPTION_3": "3",
"BLANK_1": "",
"BLANK_2": "",
"BLANK_3": "",
"OPTION_G": "\\n\\n\\n",
"OPTION_H": "\n\n\n"
}

## Dotenv load with YAML file input

### Usage

Dotenv.load('yaml.env')

### Outcome

- will read simple YAML key/values
- will escape single quote LF - '\n' to '\\n'
- will not alter double quote LF - "\n"
- will not handle YAML array types

---

```yaml
OPTION_A: 1
OPTION_B: "2"
OPTION_C: ""
OPTION_D: '\n' # I will be escaped
OPTION_E: "\n"

BLAH:
  - VALUE1
  - VALUE2 # I will be ignored
```

---

{
"OPTION_A": "1",
"OPTION_B": "2",
"OPTION_C": "",
"OPTION_D": "\\n",
"OPTION_E": "\n",
"BLAH": "- VALUE1"
}
