// Simple browser test script for DriveBossPreview.html
// Run with a browser automation tool or manually in console
function testTabs() {
  const tabNames = ['dashboard','earnings','mileage','gasfinder','carhealth','settings'];
  let allPassed = true;
  tabNames.forEach(tab => {
    const tabEl = document.querySelector('.tab[data-tab="'+tab+'"]');
    if (!tabEl) { console.error('Tab not found:', tab); allPassed = false; }
    tabEl.click();
    const view = document.getElementById(tab);
    if (!view || view.style.display === 'none') {
      console.error('View not visible for tab:', tab); allPassed = false; }
  });
  if (allPassed) console.log('Tab switching test passed!');
}

function testEarningsAdd() {
  document.querySelector('.tab[data-tab="earnings"]').click();
  document.getElementById('earning-amount').value = 99;
  document.getElementById('earning-notes').value = 'Test';
  addEarning();
  const list = document.getElementById('earnings-list');
  if (list.innerText.includes('99')) {
    console.log('Earnings add test passed!');
  } else {
    console.error('Earnings add test failed!');
  }
}

function testMileageAdd() {
  document.querySelector('.tab[data-tab="mileage"]').click();
  document.getElementById('mileage-amount').value = 55;
  document.getElementById('mileage-notes').value = 'Test';
  addMileage();
  const list = document.getElementById('mileage-list');
  if (list.innerText.includes('55')) {
    console.log('Mileage add test passed!');
  } else {
    console.error('Mileage add test failed!');
  }
}

function runAllTests() {
  testTabs();
  testEarningsAdd();
  testMileageAdd();
  // Add more as needed
}

// To run: open console in browser on DriveBossPreview.html and call runAllTests();
