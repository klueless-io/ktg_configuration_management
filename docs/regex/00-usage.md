# Regex usage patterns

Different ways of using the Regex class and the various methods plus other support classes

## initialization - Regexp.new

### .new('abc')

Creates a regular expression that can be used for matching and scanning

```ruby
creates a regular expression using Regex class
```

## initialization - /abc/

### /abc/

Syntactic sugar for creating a regular expression that can be used for matching and scanning

```ruby
creates a regular expression (syntactic sugar)
```

```ruby
forward slashes must be escaped
```

## initialization - %r{abc}

### %r{abc}

Another way of creating a regular expressions, this technique is forward slash friendly

```ruby
creates a regular expression (more syntactic sugar)
```

```ruby
forward slashes do not need to be escaped
```

## initialization - %r bracketed variations

### %r{abc} or %r(abc) or ...

Ruby supports many bracketed variations of the %r operation

```ruby
returns a regular expression
```

## match() match method

### /my expression/.match('my content')

Matches regular expression against a string. It returns the MatchData object if found or nil when not found

## match() match method match text

### /my expression/.match('my content')

Matches regular expression against a string. It returns the MatchData object if found or nil when not found

```ruby
klueless is found in content
```

## match() match method does not match text

### /my expression/.match('my content')

Matches regular expression against a string. It returns the MatchData object if found or nil when not found

```ruby
appydave is not found content
```

## =~ match operator

### /my expression/ =~ 'my content'

Matches regular expression against a string, it returns the index if found or nil when not found

## =~ match operator match text

### /my expression/ =~ 'my content'

Matches regular expression against a string, it returns the index if found or nil when not found

```ruby
klueless is found in content
```

```ruby
the order of regex and string does not mater
```

## =~ match operator does not match text

### /my expression/ =~ 'my content'

Matches regular expression against a string, it returns the index if found or nil when not found

```ruby
appydave is not found content
```

## dynamic placeholders in regular expressions

### /#{placeholder}/.match('my content')

Use dynamic placeholders to inject content into yoru regular

## dynamic placeholders in regular expressions match text

### /#{placeholder}/.match('my content')

Use dynamic placeholders to inject content into yoru regular

```ruby
klueless is found in content
```
