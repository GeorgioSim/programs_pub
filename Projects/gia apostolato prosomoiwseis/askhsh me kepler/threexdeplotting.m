load X_coordinates.txt
load Y_coordinates.txt
load Z_coordinates.txt
for i=1:length(X_coordinates)
disp(["Processing " num2str(i)]);
plot3(X_coordinates(i),Y_coordinates(i),Z_coordinates(i),'-o')
hold on;
end