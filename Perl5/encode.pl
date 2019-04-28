{
    use Encode qw();

    my $make_helper = sub {
        die unless $#_ == 1;
        die if grep {not $_} @_;
        my ($func, $encoding) = @_;
        die unless 1 == grep {$_ eq $encoding} ('UTF-8', 'shiftjis', 'cp932', 'euc-jp', 'iso-2022-jp', 'iso-2022-jp-1');
        my $helper = sub {
            die unless @_;
            die if grep {not defined $_} @_;
            die if grep {ref $_} @_;
            my @buf = map {'' . $_} @_; # shallow copy
            my @result = map {$func->($encoding, $_, Encode::FB_CROAK)} @buf;
            die if grep {not defined $_} @result;
            return wantarray ? @result : $result[0];
        };
        return $helper;
    };

    sub encode_to_shiftjis {
        return $make_helper->(\&Encode::encode, 'shiftjis')->(@_);
    }

    sub decode_from_shiftjis {
        return $make_helper->(\&Encode::decode, 'shiftjis')->(@_);
    }
}

__END__
if (1) {
    my @lines = <>;
    my @results = map {encode_to_shiftjis(decode_from_shiftjis($_))} @lines;
    print $_ foreach @results;
}
