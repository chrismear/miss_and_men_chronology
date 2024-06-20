# frozen_string_literal: true

require_relative 'lib/book'
require_relative 'lib/character'
require_relative 'lib/attribute'
require_relative 'lib/ordering'

books = []

books.push Book.new(
  'Mr. Greedy',
  changes: {
    Character['Mr Greedy'] => Attribute[:fatness].changes(from: :fat, to: :thin)
  }
)
books.push Book.new(
  'Little Miss Busy',
  appearances: { Character['Mr Greedy'] => Attribute[:fatness].is(:thin) }
)
books.push Book.new(
  'Mr. Nosey',
  changes: {
    Character['Mr Nosey'] =>
      Attribute[:noseyness].changes(from: :nosey, to: :not_nosey)
  }
)
books.push Book.new(
  'Little Miss Twins',
  appearances: { Character['Mr Nosey'] => Attribute[:noseyness].is(:nosey) }
)
books.push Book.new(
  'Mr. Chatterbox',
  changes: {
    Character['Mr Chatterbox'] =>
      Attribute[:chattiness].changes(from: :chatty, to: :quiet)
  }
)
books.push Book.new(
  'Mr. Clever',
  appearances: {
    Character['Mr Clever'] =>
      Attribute[:cleverness].is(:not_particularly_clever),
    Character['Mr Happy'] => Attribute[:happiness].is(:happy),
    Character['Mr Greedy'] => Attribute[:fatness].is(:fat),
    Character['Mr Forgetful'] => Attribute[:forgetfulness].is(:forgetful),
    Character['Mr Sneeze'] => Attribute[:sneeziness].is(:sneezy),
    Character['Mr Small'] => Attribute[:size].is(:small),
    Character['Mr Jelly'] => Attribute[:bravery].is(:timid),
    Character['Mr Topsy-Turvy'] => Attribute[:topsy_turviness].is(:topsy_turvy)
  }
)
books.push Book.new(
  'Mr. Messy',
  changes: {
    Character['Mr Messy'] =>
      Attribute[:messiness].changes(from: :messy, to: :tidy)
  }
)
books.push Book.new(
  'Mr. Brave',
  appearances: {
    Character['Mr Brave'] => Attribute[:bravery].is(:brave),
    Character['Mr Strong'] => Attribute[:strength].is(:strong),
    Character['Mr Tall'] => Attribute[:size].is(:tall),
    Character['Little Miss Bossy'] => Attribute[:bossiness].is(:bossy),
    Character['Mr Messy'] => Attribute[:messiness].is(:messy),
    Character['Little Miss Somersault'] => Attribute[:agility].is(:agile),
    Character['Little Miss Trouble'] => Attribute[:naughtiness].is(:naughty)
  }
)
books.push Book.new(
  'Mr. Dizzy',
  changes: {
    Character['Mr Dizzy'] =>
      Attribute[:dizziness].changes(from: :dizzy, to: :clever)
  }
)
books.push Book.new(
  'Little Miss Star',
  changes: {
    Character['Little Miss Star'] =>
      Attribute[:fame].changes(from: :unknown, to: :famous)
  }
)
books.push Book.new(
  'Mr. Happy',
  appearances: { Character['Mr Happy'] => Attribute[:happiness].is(:happy) },
  changes: {
    Character['Mr Miserable'] =>
      Attribute[:happiness].changes(from: :miserable, to: :happy)
  }
)
books.push Book.new(
  'Little Miss Magic',
  changes: {
    Character['Mr Tickle'] => Attribute[:tickle_frequency].changes(
      from: :often, to: :once_a_day
    )
  }
)
books.push Book.new(
  'Mr. Sneeze',
  changes: { Character['Mr Sneeze'] => Attribute[:sneeziness].changes(
    from: :sneezy, to: :not_sneezy
  ) }
)
books.push Book.new(
  'Little Miss Splendid',
  appearances: {
    Character['Little Miss Splendid'] =>
      Attribute[:splendidness].is(:splendid)
  }
)
books.push Book.new(
  'Little Miss Helpful',
  appearances: {
    Character['Little Miss Helpful'] =>
      Attribute[:helpfulness].is(:sort_of_helpful)
  }
)
books.push Book.new(
  'Mr. Worry',
  appearances: {
    Character['Mr Worry'] => Attribute[:anxiety].is(:anxious),
    Character['Mr Bump'] => Attribute[:clumsiness].is(:clumsy),
    Character['Mr Noisy'] => Attribute[:loudness].is(:loud),
    Character['Mr Greedy'] => Attribute[:fatness].is(:fat)
  }
)
books.push Book.new(
  'Mr. Forgetful',
  appearances: {
    Character['Mr Forgetful'] => Attribute[:forgetfulness].is(:forgetful)
  }
)
books.push Book.new(
  'Little Miss Somersault',
  appearances: {
    Character['Little Miss Somersault'] => Attribute[:agility].is(:agile),
    Character['Mr Worry'] => Attribute[:anxiety].is(:anxious),
    Character['Mr Skinny'] => Attribute[:fatness].is(:thin),
    Character['Mr Bump'] => Attribute[:clumsiness].is(:clumsy),
    Character['Mr Uppity'] => Attribute[:haughtiness].is(:uppity)
  }
)
books.push Book.new(
  'Little Miss Late',
  appearances: {
    Character['Mr Greedy'] => Attribute[:fatness].is(:fat),
    Character['My Lazy'] => Attribute[:laziness].is(:lazy)
  }
)
books.push Book.new(
  'Mr. Good',
  changes: {
    Character['Mr Good'] => [
      Attribute[:happiness].changes(from: :miserable, to: :happy),
      Attribute[:country].changes(from: :badland, to: :goodland)
    ]
  }
)
books.push Book.new(
  'Little Miss Naughty',
  changes: {
    Character['Little Miss Naughty'] => Attribute[:naughtiness].changes(
      from: :naughty, to: :nice
    )
  },
  appearances: {
    Character['Mr Busy'] => Attribute[:busyness].is(:busy)
  }
)
books.push Book.new(
  'Mr. Grumble',
  changes: {
    Character['Mr Grumble'] => Attribute[:grumpiness].changes(from: :grumpy,
                                                              to: :cheerful)
  }
)
books.push Book.new(
  'Little Miss Dotty'
)
books.push Book.new(
  'Mr. Lazy'
)
books.push Book.new(
  'Mr. Skinny',
  changes: {
    Character['Mr Skinny'] =>
      Attribute[:fatness].changes(from: :thin, to: :plumper)
  },
  appearances: { Character['Mr Greedy'] => Attribute[:fatness].is(:fat) }
)
books.push Book.new(
  'Mr. Snow'
)
books.push Book.new(
  'Mr. Bump',
  appearances: { Character['Mr Bump'] => Attribute[:clumsiness].is(:clumsy) },
  changes: { Character['Mr Bump'] => Attribute[:employment].changes(
    from: :unemployed, to: :employed
  ) }
)
books.push Book.new(
  'Mr. Nosey and the big surprise',
  appearances: {
    Character['Mr Nosey'] => Attribute[:noseyness].is(:nosey),
    Character['Mr Mischief'] => Attribute[:mischievousness].is(:mischievous)
  }
)
books.push Book.new(
  'All Different',
  appearances: {
    Character['Little Miss Tiny'] => Attribute[:size].is(:tiny),
    Character['Mr Tall'] => Attribute[:size].is(:tall),
    Character['Little Miss Sunshine'] => Attribute[:happiness].is(:happy),
    Character['Mr Grumpy'] => Attribute[:grumpiness].is(:grumpy),
    Character['Little Miss Neat'] => Attribute[:neatness].is(:neat),
    Character['Mr Messy'] => Attribute[:messiness].is(:messy),
    Character['Mr Strong'] => Attribute[:strength].is(:strong),
    Character['Mr Jelly'] => Attribute[:bravery].is(:timid),
    Character['Little Miss Chatterbox'] => Attribute[:chattiness].is(:chatty),
    Character['Mr Quiet'] => Attribute[:loudness].is(:quiet),
    Character['Little Miss Quick'] => Attribute[:speed].is(:quick),
    Character['Mr Slow'] => Attribute[:speed].is(:slow),
    Character['Little Miss Splendid'] => Attribute[:splendidness].is(:splendid),
    Character['Mr Silly'] => Attribute[:silliness].is(:silly),
    Character['Little Miss Naughty'] => Attribute[:naughtiness].is(:naughty),
    Character['Little Miss Twin 1'] => Attribute[:naughtiness].is(:nice),
    Character['Little Miss Twin 2'] => Attribute[:naughtiness].is(:naughty),
    Character['Mr Perfect'] => Attribute[:naughtiness].is(:nice)
  }
)
books.push Book.new(
  'Mr. Topsy-Turvy',
  appearances: {
    Character['Mr Topsy-Turvy'] => Attribute[:topsy_turviness].is(:topsy_turvy)
  }
)
books.push Book.new(
  'Mr. Funny',
  appearances: { Character['Mr Funny'] => Attribute[:funniness].is(:funny) }
)
books.push Book.new(
  'Mr. Tickle',
  appearances: {
    Character['Mr Tickle'] => Attribute[:tickle_frequency].is(:often)
  }
)

Ordering.new(books).to_image('little-miss-and-mr-men-ordering')
