function column_indices = getColumnIndices(labels, column_names)
% grab multiple columns
% grab frequency and control?

column_indices = zeros(numel(labels), 1);
for i = 1:numel(labels)
    column_index = getColumnIndex(labels(i), column_names);
    column_indices(i) = column_index;
end
