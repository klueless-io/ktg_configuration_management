# Regex literal matching

Match against simple text literals

## Regexp initialization - Regexp.new

### Regexp.new('abc')

Creates a regular expression that can be used for matching and scanning

#### returns a regular expression

```ruby
<-- inject from block
```

## Regexp initialization - /abc/

### /abc/

Syntactic sugar for creating a regular expression that can be used for matching and scanning

#### returns a regular expression

```ruby
<-- inject from block
```

#### forward slashes must be escaped

```ruby
<-- inject from block
```

## Regexp initialization - %r{abc}

### %r{abc}

Another way of creating a regular expressions, this technique is forward slash friendly

#### returns a regular expression

```ruby
<-- inject from block
```

#### forward slashes do not need to be escaped

```ruby
<-- inject from block
```

## Regexp initialization - %r bracketed variations

### %r{abc} or %r(abc) or ...

Ruby supports many bracketed variations of the %r operation

#### returns a regular expression

```ruby
<-- inject from block
```

## Regexp match simple literal expression

### "my abc".match(/abc/)

Creates a simple literal RegEx that can be used for matching

#### finds a simple literal expression

```ruby
<-- inject from block
```

## Regexp match multiple occurances of simple expressions

### "abc and abc or abc".match(/abc/)

Matches against a literal expression multiple times

#### find first occurance

```ruby
<-- inject from block
```

#### Find second occurance

```ruby
<-- inject from block
```

#### Third match should not be found

```ruby
<-- inject from block
```

## Regexp match find simple literal that occurs multiple times and return the index positions

### "aaaaaa".index(/aaa/)

Matches short literal expressions against longer content and returns the index

#### find first occurance

```ruby
<-- inject from block
```

#### Find second occurance

```ruby
<-- inject from block
```

#### Find third occurance

```ruby
<-- inject from block
```

#### Find fourth occurance

```ruby
<-- inject from block
```
