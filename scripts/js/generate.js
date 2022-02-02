const { readdirSync, readFileSync, writeFileSync } = require("fs");
const { resolve, basename } = require("path");
const { readdir } = require("fs").promises;

/**
 * Performs a deep walk of the given folder and returns an array of files.
 *
 * @param {string} folder - The folder to walk.
 * @returns {string[]} An array of files.
 */
async function getFiles(folder) {
  const dirents = await readdir(folder, { withFileTypes: true });
  const files = await Promise.all(
    dirents.map((dirent) => {
      const res = resolve(folder, dirent.name);
      return dirent.isDirectory() ? getFiles(res) : res;
    })
  );
  return files.flat();
}

/**
 * Performs a deep merge of objects and returns new object. Does not modify
 * objects (immutable) and merges arrays via concatenation.
 *
 * @param {...object} objects - The object(s) to merge.
 * @returns {object} The new object after merging.
 */
function merge(...objects) {
  const isObject = (obj) => obj && typeof obj === "object";

  return objects.reduce((prev, obj) => {
    Object.keys(obj).forEach((key) => {
      const pVal = prev[key];
      const oVal = obj[key];

      if (Array.isArray(pVal) && Array.isArray(oVal)) {
        prev[key] = pVal.concat(...oVal);
      } else if (isObject(pVal) && isObject(oVal)) {
        prev[key] = merge(pVal, oVal);
      } else {
        prev[key] = oVal;
      }
    });

    return prev;
  }, {});
}

// Read and Generate from FS

async function make() {
  const upstreamContent = readFileSync(
    resolve(__dirname, "../../sys/data/_.msf.json")
  );
  const jsonContent = readFileSync(
    resolve(__dirname, "../../conf.d/inject.json")
  );

  const upstream = JSON.parse(upstreamContent);
  const inject = JSON.parse(jsonContent);

  const final = merge(upstream, inject);

  writeFileSync(
    resolve(__dirname, "../../sys/data/_r.msf.json"),
    JSON.stringify(final, null, 2)
  );
}

make();
