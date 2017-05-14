package BBS::Model::DB;

use strict;
use warnings;
use utf8;

use DBI;

use Mouse::Role;

has conf => (
    is => 'ro',
    default => sub { do 'etc/bbs.conf' or die $! }
);

has dsn => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my $database = $self->conf->{database};
        my $dbname   = $database->{name};
        my $username = $database->{username};
        my $password = $database->{password};
        return +["dbi:Pg:dbname=$dbname", $username, $password, +{ RaiseError => 1 }];
    }
);

has dbh => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $self = shift;
        ( return DBI->connect(@{ $self->dsn }) ) or die $!;
    }
);

__PACKAGE__->meta->make_immutable;

1;