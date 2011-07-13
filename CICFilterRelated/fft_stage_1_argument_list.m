cfg.source = str2func('fft_stage_1');
cfg.toplevel = gcb;
args = {3, 1, 18, 18, 'off', 1, 2, 2, 1, 'Round (unbiased: +/- Inf)', 'Saturate', 'Virtex5', 'Logic', 'off', 'off', 'on', 'off', 'off', 'off'};
xBlock(cfg, args);
