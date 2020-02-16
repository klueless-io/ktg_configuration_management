# Regex literal matching

Match against simple text literals

## Regexp initialization - Regexp.new

### Regexp.new('abc')

Creates a regular expression that can be used for matching and scanning

```ruby
returns a regular expression
```

## Regexp initialization - /abc/

### /abc/

Syntactic sugar for creating a regular expression that can be used for matching and scanning

```ruby
returns a regular expression
```

```ruby
forward slashes must be escaped
```

## Regexp initialization - %r{abc}

### %r{abc}

Another way of creating a regular expressions, this technique is forward slash friendly

```ruby
returns a regular expression
```

```ruby
forward slashes do not need to be escaped
```

## Regexp initialization - %r bracketed variations

### %r{abc} or %r(abc) or ...

Ruby supports many bracketed variations of the %r operation

```ruby
returns a regular expression
```

## Regexp match - /exp/.match("some text")

### /abc/.match("input text with abc in it")

Creates a regular expression that can be used for matching and scanning

```ruby
returns a regular expression
```
