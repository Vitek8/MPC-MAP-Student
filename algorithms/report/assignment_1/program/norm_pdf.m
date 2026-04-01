function p = norm_pdf(x, mu, sigma)
    p = (1 / (sigma * sqrt(2*pi))) * exp(-((x - mu).^2) / (2*sigma^2));
end