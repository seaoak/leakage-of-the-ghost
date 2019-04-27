{
    use Encode qw();

    sub encode_to_shiftjis {
        die unless @_;
        die if grep {not defined $_} @_;
        die if grep {ref $_} @_;
        my @buf = map {'' . $_} @_; # shallow copy
        my @result = map {Encode::encode('shiftjis', $_, Encode::FB_CROAK)} @buf;
        die if grep {not defined $_} @result;
        return wantarray ? @result : $result[0];
    }

    sub decode_from_shiftjis {
        die unless @_;
        die if grep {not defined $_} @_;
        die if grep {ref $_} @_;
        my @buf = map {'' . $_} @_; # shallow copy
        my @result = map {Encode::decode('shiftjis', $_, Encode::FB_CROAK)} @buf;
        die if grep {not defined $_} @result;
        return wantarray ? @result : $result[0];
    }
}

__END__
if (1) {
    my @lines = <>;
    my @results = map {encode_to_shiftjis(decode_from_shiftjis($_))} @lines;
    print $_ foreach @results;
}
