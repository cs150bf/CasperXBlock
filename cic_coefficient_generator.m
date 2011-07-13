function coefficients = cic_coefficient_generator(m, dec_rate)
if ~isprime(dec_rate)
    disp('Only supports decimation rate that''s a prime number');
    return;
end

% H(z) = (1 + z^-1 + z^-2 + ... + z^-(dec_rate-1))^m
% the result would be consist of terms from z^0 to z^-(dec_rate-1)*m

coeffs = zeros(1, (dec_rate-1)*m+1);
coeffs(1) = 1;

% solve for equation x1 + x2 + .. + x_m = i
for i = 1:(dec_rate-1)
    coeffs(i+1) = factorial(i+m-1)./(factorial(m -1) * factorial(i));
end



for i =dec_rate: (dec_rate-1)*m
    coeffs(i+1) = dumb_count(i,m, dec_rate-1);
end

    function final_count =dumb_count(dsum, n_inputs, limit)
        x_i = zeros(1,n_inputs);
        total_comb = (limit+1)^n_inputs;
        comb_count = 1;
        count = 0;
        function new_comb = next_comb(current_comb,limit)
            current_comb(end) = current_comb(end)  +1;
            if current_comb(end) > limit
                current_comb(end) = 0;
                current_comb(1:end-1) = next_comb(current_comb(1:end-1),limit);
                new_comb = current_comb;
            else
                new_comb = current_comb;
            end
        end

        x_i(end) = -1;
        while comb_count <= total_comb
            x_i = next_comb(x_i,limit);
            comb_count = comb_count +1;
            temp_sum = sum(x_i);
            if temp_sum == dsum
                count = count +1;
            end
        end
        
        final_count = count;
        
    end


coefficients = coeffs;
end